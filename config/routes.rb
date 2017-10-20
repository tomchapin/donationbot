Rails.application.routes.draw do
  root to: 'visitors#index'

  post 'twilio/voice' => 'twilio#voice'
end
