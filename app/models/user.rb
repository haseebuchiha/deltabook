class User < ApplicationRecord
  has_many :game_users
  has_many :games, through: :game_users

  validates :username, presence: true, length: {minimum: 3, maximum: 25}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end