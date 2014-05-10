class API < Grape::API
  format :json

  version 'v1.0', :using => :path
  # rescue_from :all

  helpers do
    def authenticate!
      error!('Unauthorized. Invalid or expired token.', 401) unless current_user
    end

    def current_user
      @current_user = User.find_by_email(params[:email])
    end
  end

  mount EventsApi
end
