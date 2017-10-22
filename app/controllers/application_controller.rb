class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ApplicationHelper

  protected
  def authenticate_api_user!
    if params['token'] != ENV['API_AUTH_KEY']
      redirect_to :action => 'forbidden', :status => 403
    end
  end

  def authenticate_admin_user!
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
    end
  end

end
