class ApplicationController < ActionController::API

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  protected

  def authenticate
    if ENV['BASIC_AUTH_USERNAME'] && ENV['BASIC_AUTH_PASSWORD']
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['BASIC_AUTH_USERNAME'] && password == ENV['BASIC_AUTH_PASSWORD']
      end
    end
  end
end
