class Chat < ApplicationRecord
  belongs_to :group
  belongs_to :customer
  
  validates :content, presence: true
end
