class Event < ApplicationRecord
  
  belongs_to :customer
  alias_attribute :start_time, :date
  
  enum schedule: {
    available: 0, 
    practice: 1, 
    golf: 2, 
    other: 3
  }
end
