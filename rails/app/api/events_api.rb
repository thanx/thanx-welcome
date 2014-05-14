class EventsApi < Grape::API
  resource :events do
    post '/' do
      authenticate!
      @current_user.events.create(ibeacon_id: params[:ibeacon_id])
      song = @current_user.songs.first
      if song.present?
        Music::Player.play(song.track_id)
        sleep 10
        Music::Player.stop
      end
      {}
    end
  end
end
