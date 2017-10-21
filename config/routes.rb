Rails.application.routes.draw do

  root to: 'visitors#index'

  post 'twilio/voice' => 'twilio#voice'

  post 'twilio/recieve_sms' => 'twilio#recieve_sms'

  post 'slack/balance' => 'slack#balance'
end
