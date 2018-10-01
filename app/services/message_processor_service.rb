class MessageProcessorService
  include ApplicationHelper

  def initialize(incoming_message)
    @incoming_message = incoming_message
  end

  def perform

    begin
      sms_message = @incoming_message.body
      notification_message = nil

      fund = SquareCashFund.find_by_phone_number(@incoming_message.to)
      if fund

        # Check for matches
        # Example message: 28581 - Cash App: Tom Chapin sent you $1 for donuts.
        money_received_for_reason_match = sms_message.match(/(?:Square Cash|Cash App): (.*) sent you \$(.*) for (.*)/)
        money_received_match = sms_message.match(/(?:Square Cash|Cash App): (.*) sent you \$(.*)/)
        money_spent_match = sms_message.match(/(?:Square Cash|Cash App): You spent \$(.*) at (.*)/)

        if money_received_for_reason_match
          puts 'Money received!'
          transaction = fund.square_cash_transactions.create(person_name: money_received_for_reason_match[1],
                                                             amount: BigDecimal.new(money_received_for_reason_match[2]),
                                                             message: money_received_for_reason_match[3],
                                                             balance: fund.balance + BigDecimal.new(money_received_for_reason_match[2]))

          notification_message = "#{big_decimal_to_currency transaction.amount} donation received from #{transaction.person_name} (#{transaction.message})! The current #{fund.name} balance is now #{big_decimal_to_currency transaction.balance}"

        elsif money_received_match
          puts 'Money received!'
          transaction = fund.square_cash_transactions.create(person_name: money_received_match[1],
                                                             amount: BigDecimal.new(money_received_match[2]),
                                                             message: '',
                                                             balance: fund.balance + BigDecimal.new(money_received_for_reason_match[2]))

          notification_message = "#{big_decimal_to_currency transaction.amount} donation received from #{transaction.person_name}! The current #{fund.name} balance is now #{big_decimal_to_currency transaction.balance}"

        elsif money_spent_match
          puts 'Money spent!'
          amount_spent = BigDecimal.new(money_spent_match[1])
          new_balance = fund.balance - amount_spent
          transaction = fund.square_cash_transactions.create(person_name: 'Me',
                                                             amount: amount_spent * -1,
                                                             message: money_spent_match[2],
                                                             balance: new_balance)

          notification_message = "#{big_decimal_to_currency amount_spent} spent at #{transaction.message}. The current #{fund.name} balance is now #{big_decimal_to_currency transaction.balance}"

        else
          raise 'Unable to match SMS message to regex patterns!'
        end

        # Post the notification message to the fund's Slack channel
        outgoing_slack_message = OutgoingSlackMessage.create(message: notification_message, square_cash_fund: fund)
        outgoing_slack_message.send_to_slack

      else
        raise 'Fund in database not found for specified phone number!'
      end

      # Mark the message as processed
      @incoming_message.update(processed: true, processed_at: Time.now)

    rescue Exception => e
      @incoming_message.update(processing_error: e.to_s)
      raise e
    end

  end
end