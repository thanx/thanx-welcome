class Song < ActiveRecord::Base
  belongs_to :users

  validates :track_id, uniqueness: { scope: :user_id }
  validates_numericality_of :start_at
  validates_numericality_of :end_at, greater_than: :start_at

  def play
    tunes = RubyTunes.new
    tunes.playback.volume = 0
    RubyTunes::Track.new(id: self.track_id).play
    tunes.playback.position = self.start_at
    tunes.fade.in
    sleep(self.end_at - self.start_at)
    tunes.fade.out
    tunes.playback.pause
  end

end
