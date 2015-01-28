class Song < ActiveRecord::Base
  belongs_to :users

  validates :track_id, uniqueness: { scope: :user_id }
  validates_numericality_of :start_at
  validates_numericality_of :end_at, greater_than: :start_at

  def play
    suppress_spotify do
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

private

  def suppress_spotify
    spotify_is_playing = true if spotify? && spotify_state == 'playing'
    pause_spotify if spotify_is_playing

    yield

    play_spotify if spotify_is_playing
  end

  def spotify_state
    run('tell app "Spotify" to player state')
  end

  def pause_spotify
    run('tell app "Spotify" to pause')
  end

  def play_spotify
    run('tell app "Spotify" to play')
  end

  def spotify?
    run('tell app "System Events" to count processes whose name is "Spotify"').to_i == 1
  end

  def run(command)
    `osascript -e '#{command}'`.strip
  end

end
