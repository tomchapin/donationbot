require 'slack-notifier'

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Yay! You're on Rails!", voice: "alice"
      r.Sms "Well done building your first Twilio on Rails 5 app!"
      r.Play "http://linode.rabasa.com/cantina.mp3"
    end
    render :xml => response.to_xml
  end

  def recieve_sms
    sms_message = params['Body']
    parsed_message = sms_message.match(/Square Cash: (.*) sent you \$(.*) for (.*). You now have \$(.*) available in your Cash app/)
    donator = parsed_message[1]
    donation_amount = parsed_message[2]
    donation_message = parsed_message[3]
    balance = parsed_message[4]
    notification_message = "$#{donation_amount} donation received from #{donator} (#{donation_message})! The current donut fund balance is now $#{balance}."

    puts notification_message

    notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
    notifier.ping notification_message
  end
end
