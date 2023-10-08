class Post < ApplicationRecord
  
  has_one_attached :post_image
  
  def get_post_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height]).processed
    end
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(name: content)
    elsif method == 'forward'
      Post.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('name LIKE ?', '%' + content)
    else
      Post.where('name LIKE ?', '%' + content + '%')
    end
  end
  
end
