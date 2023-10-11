class Post < ApplicationRecord
  
  has_one_attached :post_image
  
  has_many :favorites
  has_many :likers, through: :favorites, source: :customer
  has_many :comments, dependent: :destroy
  belongs_to :customer
  
  def get_post_image(width, height)
    if post_image.attached?
      post_image.variant(resize_to_limit: [width, height]).processed
    end
  end
  
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
  
  def self.search_for(content)
    Post.where('body LIKE ?', '%' + content + '%')
  end
  
end
