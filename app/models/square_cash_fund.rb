class SquareCashFund < ApplicationRecord
    has_many :square_cash_transactions, dependent: :destroy
end
