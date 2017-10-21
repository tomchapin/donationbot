class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def balance
    respond_to do |format|
      msg = { :text => "THis is a response!", :mrkdwn => true }
      format.json  { render :json => msg }
    end
  end
end
