class Event < ApplicationRecord
  
  belongs_to :customer
  alias_attribute :start_time, :date
  
  validates :schedule, presence: true
  validates :date, presence: true
  
  enum schedule: {
    available: 0, 
    practice: 1, 
    golf: 2, 
    other: 3
  }
end
