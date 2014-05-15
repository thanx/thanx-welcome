class Event < ActiveRecord::Base
  belongs_to :user

  after_create :play_song

  protected

    def play_song
      song = self.user.songs.offset(rand(self.user.songs.count)).first
      if song.present?
        Music::Player.pause
        Music::Player.volume = 0
        Music::Player.play(song.track_id)
        Music::Player.position = song.start_at.to_f
        # fade in

        Music::Player.volume = 100
        sleep (song.end_at - song.start_at)

        # fade out
        Music::Player.volume = 0
        Music::Player.stop
      end
    end
    handle_asynchronously :play_song

end
