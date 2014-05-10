class Song < ActiveRecord::Base
  belongs_to :users

  validates :track_id, uniqueness: { scope: :user_id}
end
