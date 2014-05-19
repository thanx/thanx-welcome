class EventsApi < Grape::API
  resource :events do
    post '/' do
      Rails.logger.info params.to_yaml
      authenticate!
      @current_user.events.create(ibeacon_id: params[:ibeacon_id])
      {}
    end
  end
end
