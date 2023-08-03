class Feed < ApplicationRecord
    validates :title, presence: true, length: {minimum: 3, maximum: 30}
    validates :description, presence: true, length: {minimum: 10, maximum: 256}
    has_many_attached :media

    def has_media?
        media.attached?
    end
end