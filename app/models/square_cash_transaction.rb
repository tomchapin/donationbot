class SquareCashTransaction < ApplicationRecord
    belongs_to :square_cash_fund
    validates :person_name, presence: true
    validates :amount, numericality: true, presence: true
    validates :balance, numericality: true, presence: true
end
