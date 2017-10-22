class RemoteEmbedsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_fund_from_params, only: [:fund_status, :previous_donors]

  def fund_status
    @fund_balance = big_decimal_to_currency(@fund.balance)
    @recent_transactions= @fund.square_cash_transactions.order(:created_at).limit(6)
    respond_to do |format|
      format.js
    end
  end

  def previous_donors
    @all_transactions = @fund.square_cash_transactions.order(:created_at)
    respond_to do |format|
      format.js
    end
  end

  private

  def set_fund_from_params
    fund_name = params.fetch(:fund_name, nil)
    @fund = SquareCashFund.find_by_name(fund_name)
  end

end
