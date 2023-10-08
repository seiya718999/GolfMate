class Post < ApplicationRecord
  
  has_one_attached :post_image
  
  def get_post_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height]).processed
    end
  end
  
end
