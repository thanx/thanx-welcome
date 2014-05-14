class EventsApi < Grape::API
  resource :events do
    post '/' do
      Rails.logger.info params.to_yaml
      authenticate!
      @current_user.events.create(ibeacon_id: params[:ibeacon_id])
      song = @current_user.songs.first
      if song.present?
        Music::Player.pause
        Music::Player.volume = 0
        Music::Player.play(song.track_id)
        Music::Player.position = song.start_at.to_f
        Music::Player.volume = 100
        sleep (song.end_at - song.start_at)
        Music::Player.stop
      end
      {}
    end
  end
end
