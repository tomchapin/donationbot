class RemoteEmbedsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def fund_status
    fund_name = params.fetch(:fund_name, nil)
    @fund_balance = big_decimal_to_currency(SquareCashFund.find_by_name(fund_name).balance)

    respond_to do |format|
      format.js
    end
  end
end
