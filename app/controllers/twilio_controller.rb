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
    notification_message = nil
    sms_message = params['Body']

    fund = SquareCashFund.find_by_phone_number(params['To'])
    if sms_message && fund

      # Handle SMS messages about money being received
      money_received_match = sms_message.match(/Square Cash: (.*) sent you \$(.*) for (.*). You now have \$(.*) available in your Cash app/)
      if money_received_match
        transaction = fund.square_cash_transactions.create(person_name: money_received_match[1],
                                                           amount: BigDecimal.new(money_received_match[2]),
                                                           message: money_received_match[3],
                                                           balance: BigDecimal.new(money_received_match[4]))
        notification_message = "#{big_decimal_to_currency transaction.amount} donation received from #{transaction.person_name} (#{transaction.message})! The current #{fund.name} balance is now #{big_decimal_to_currency transaction.balance}"
      end

      # Handle SMS messages about money being spent
      money_spent_match = sms_message.match(/Square Cash: You spent \$(.*) at (.*)/)
      if money_spent_match
        most_recent_transaction = fund.square_cash_transactions.order(:created_at).last
        current_balance = most_recent_transaction.balance rescue BigDecimal.new('0')
        amount_spent = BigDecimal.new(money_spent_match[1])
        new_balance = current_balance - amount_spent
        transaction = fund.square_cash_transactions.create(person_name: 'Me',
                                                           amount: amount_spent,
                                                           message: money_spent_match[2],
                                                           balance: new_balance)
        notification_message = "#{big_decimal_to_currency transaction.amount} spent at #{transaction.message}. The current #{fund.name} balance is now #{big_decimal_to_currency transaction.balance}"
      end

      # Post the notification message to the fund's Slack channel
      if notification_message
        puts notification_message
        notifier = Slack::Notifier.new fund.slack_webhook_url
        notifier.ping notification_message
      end
    end
  end

end
