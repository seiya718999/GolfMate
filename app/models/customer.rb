class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :liked_posts, through: :favorites, source: :post
  
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_many :events, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :group_customers, dependent: :destroy
  has_many :groups, through: :group_customers, source: :group
  
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
  has_many :chats
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :email, presence: true, uniqueness: true
  
  enum gender: { male: 0, female: 1, other: 2 }
  enum play_style: {
    competitive: 0, 
    moderately_serious: 1, 
    want_to_improve: 2, 
    fun_is_enough: 3, 
    for_health: 4
  }
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  PREFECTURES = %w[
    北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県
    茨城県 栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県
    新潟県 富山県 石川県 福井県 山梨県 長野県
    岐阜県 静岡県 愛知県 三重県
    滋賀県 京都府 大阪府 兵庫県 奈良県 和歌山県
    鳥取県 島根県 岡山県 広島県 山口県
    徳島県 香川県 愛媛県 高知県
    福岡県 佐賀県 長崎県 熊本県 大分県 宮崎県 鹿児島県 沖縄県
  ]
  
  def self.search_for(content)
    # 部分一致のLIKEクエリのパターンを作成
    like_content = '%' + content + '%'
    
    # 苗字と名前を連結して、それに対して検索を行う条件
    if Rails.env.development?
        # SQLite3
        full_name_condition = "(last_name || first_name) LIKE :like_content"
    else
        # MySQL
        full_name_condition = "CONCAT(last_name, first_name) LIKE :like_content"
    end
  
    # 各カラムで検索条件を作成
    where_clause = %w[last_name first_name last_name_kana first_name_kana].map do |column_name|
      "#{column_name} LIKE :like_content"
    end
    
    where_clause << full_name_condition
    final_clause = where_clause.join(' OR ')
    Customer.where(final_clause, like_content: like_content)
  end
  
  def following?(customer)
    followings.include?(customer)
  end
  
  #ゲストログイン用
  GUEST_USER_EMAIL = "guest@example.com"
  
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.last_name = "guest"
      customer.first_name = "user"
      customer.last_name_kana = "げすと"
      customer.first_name_kana = "ゆーざー"
    end
  end
  
  def guest_customer?
    email == GUEST_USER_EMAIL
  end
  
  def create_notification_follow!(current_customer)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_customer.id, id, 'follow'])
    if temp.blank?
      notification = current_customer.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  
end
