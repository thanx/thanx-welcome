class Event < ActiveRecord::Base
  belongs_to :user

  after_create :play_song

  protected

    def play_song
      song = self.user.songs.offset(rand(self.user.songs.count)).first
      if song.present?
        Music::Switcher.switch(song.track_id, song.start_at, song.end_at)
      end
    end
    handle_asynchronously :play_song

end
