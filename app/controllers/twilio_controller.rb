require 'slack-notifier'

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_api_user!
  before_action :set_incoming_message, only: :receive_sms

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Yay! You're on Rails!", voice: "alice"
      r.Sms "Well done building your first Twilio on Rails 5 app!"
      r.Play "http://linode.rabasa.com/cantina.mp3"
    end
    render :xml => response.to_xml
  end

  def receive_sms
    @incoming_message.save!

    message_processor = MessageProcessorService.new(@incoming_message)
    message_processor.perform

    # If no exceptions were encountered, we render status of "created" (201)
    head :created
  end

  private

  def incoming_message_params
    convert_keys_to_underscore(params.permit(
      :ToCountry,
      :ToState,
      :SmsMessageSid,
      :NumMedia,
      :ToCity,
      :FromZip,
      :SmsSid,
      :FromState,
      :SmsStatus,
      :FromCity,
      :Body,
      :FromCountry,
      :To,
      :ToZip,
      :NumSegments,
      :MessageSid,
      :AccountSid,
      :From,
      :ApiVersion
    ))
  end

  def convert_keys_to_underscore(dict)
    new_dict = {}
    dict.keys.each do |key|
      new_dict[key.underscore] = dict[key]
    end
    new_dict
  end

  def set_incoming_message
    @incoming_message = IncomingMessage.new(incoming_message_params)
  end

end


