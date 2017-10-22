Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  root to: 'visitors#index'

  post 'twilio/voice' => 'twilio#voice'
  post 'twilio/receive_sms' => 'twilio#receive_sms'

  post 'slack/balance' => 'slack#balance'

  get 'remote_embeds/fund_status' => 'remote_embeds#fund_status'
  get 'remote_embeds/previous_donors' => 'remote_embeds#previous_donors'

end
