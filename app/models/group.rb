class Group < ApplicationRecord
  
  has_many :group_customers, dependent: :destroy
  has_many :customers, through: :group_customers, source: :customer
  has_many :chats
  
end
