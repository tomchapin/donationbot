require 'slack-notifier'

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_api_user!

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Yay! You're on Rails!", voice: "alice"
      r.Sms "Well done building your first Twilio on Rails 5 app!"
      r.Play "http://linode.rabasa.com/cantina.mp3"
    end
    render :xml => response.to_xml
  end

  def receive_sms
    sms_message = params['Body']
    transaction_received = sms_message.match(/Square Cash: (.*) sent you \$(.*) for (.*). You now have \$(.*) available in your Cash app/)
    if transaction_received

      fund = SquareCashFund.find_by_phone_number(params['To'])
      if fund
        transaction = fund.square_cash_transactions.create(person_name: transaction_received[1],
                                                           amount: BigDecimal.new(transaction_received[2]),
                                                           message: transaction_received[3],
                                                           balance: BigDecimal.new(transaction_received[4]))
        notification_message = "#{big_decimal_to_currency transaction.amount} donation received from #{transaction.person_name} (#{transaction.message})! The current donut fund balance is now #{big_decimal_to_currency transaction.balance}"
        puts notification_message
        notifier = Slack::Notifier.new fund.slack_webhook_url
        notifier.ping notification_message
      end

    end
  end

end
