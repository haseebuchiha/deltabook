class Feed < ApplicationRecord
    validates :title, presence: true, length: {minimum: 3, maximum: 30}
    validates :description, presence: true, length: {minimum: 10, maximum: 256}
    
end