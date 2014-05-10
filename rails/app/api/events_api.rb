class EventsApi < Grape::API
  resource :events do
    post '/' do
      authenticate!

      @current_user.events.create( ibeacon_id: params[:ibeacon_id])
    end
  end
end
