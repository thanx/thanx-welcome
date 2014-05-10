class EventsApi < Grape::API
  resource :events do
    post '/' do
      authenticate!
      @current_user.events.create( ibeacon_id: params[:ibeacon_id])
      Music::Player.play('0890B76B47ADFFD8')
      Music::Player.position = 45
      sleep 10
      Music::Player.stop
      {}
    end
  end
end
