class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

    def authenticate
      if ENV['WELCOME_USERNAME'].present? && ENV['WELCOME_PASSWORD'].present?
        authenticate_or_request_with_http_basic do |username, password|
          username == ENV['WELCOME_USERNAME'] &&
          password == ENV['WELCOME_PASSWORD']
        end
      end
    end

end
