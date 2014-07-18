class AuthApi < Grape::API
  resource :auth do
    post '/' do
      # @todo find api key for params["email"] & params["password"]
      {api_key: 101010101010}
    end
  end
end
