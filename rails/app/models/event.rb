class Event < ActiveRecord::Base
  belongs_to :user

  after_create :play_song

  protected

    def play_song
      events = self.user.events.where(
        'created_at >= ? AND created_at < ?',
        Time.current.beginning_of_day, self.created_at
      )
      if events.blank?
        song = self.user.songs.offset(rand(self.user.songs.count)).first
        if song.present?
          puts "Playing #{song.track_id} for #{self.user.first_name}"
          Music::Switcher.switch(song.track_id, song.start_at, song.end_at)
        end
      end
    end
    handle_asynchronously :play_song

end
