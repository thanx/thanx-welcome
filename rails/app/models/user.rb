class User < ActiveRecord::Base
  has_many :songs
  has_many :events

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
end
