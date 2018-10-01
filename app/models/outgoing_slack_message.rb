class OutgoingSlackMessage < ApplicationRecord

  belongs_to :square_cash_fund

  def send_to_slack
    puts message
    notifier = Slack::Notifier.new square_cash_fund.slack_webhook_url
    result = notifier.ping(message)
    if result.code == '200'
      self.update(posted_to_slack: true, posted_to_slack_at: Time.now)
    end

  end

end
