class CreateSquareCashTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :square_cash_transactions do |t|
      t.belongs_to :square_cash_fund, index: true, foreign_key: true
      t.string :person_name, limit: 255, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :message, limit: 255, null: true
      t.decimal :balance, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
