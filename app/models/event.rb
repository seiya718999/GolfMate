class Event < ApplicationRecord
  
  enum schedule: {
    available: 0, 
    practice: 1, 
    golf: 2, 
    other: 3
  }
end
