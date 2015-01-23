class Song < ActiveRecord::Base
  belongs_to :users

  validates :track_id, uniqueness: { scope: :user_id }
  validates_numericality_of :start_at
  validates_numericality_of :end_at, greater_than: :start_at

  def play
    Music::Switcher.switch(self.track_id, self.start_at, self.end_at)
  end

end
