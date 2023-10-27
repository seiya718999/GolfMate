class Comment < ApplicationRecord
  
  belongs_to :post
  belongs_to :customer
  has_many :notifications, dependent: :destroy
  validates :body, presence: true
end
