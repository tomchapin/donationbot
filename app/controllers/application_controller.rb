class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
  def authenticate_api_user!
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['API_USERNAME'] && password == ENV['API_PASSWORD']
    end
  end

  def authenticate_admin_user!
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
    end
  end

end
