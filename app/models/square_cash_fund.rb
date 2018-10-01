class SquareCashFund < ApplicationRecord
  has_many :square_cash_transactions, dependent: :destroy
  has_many :outgoing_slack_messages, dependent: :destroy

  def balance
    most_recent_transaction = self.square_cash_transactions.order(created_at: :desc).first
    most_recent_transaction.balance rescue BigDecimal.new('0')
  end

end
