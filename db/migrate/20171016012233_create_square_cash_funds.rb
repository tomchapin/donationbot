class CreateSquareCashFunds < ActiveRecord::Migration[5.1]
  def change
    create_table :square_cash_funds do |t|
      t.string :name, limit: 100, null: false
      t.string :phone_number, limit: 20, null: false
      t.string :slack_webhook_url, limit: 255, null: false

      t.timestamps
    end
  end
end
