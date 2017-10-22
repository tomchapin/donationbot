module ApplicationHelper

  def big_decimal_to_currency(bd)
    '$%.2f' %bd.truncate(2).to_s('F')
  end

end
