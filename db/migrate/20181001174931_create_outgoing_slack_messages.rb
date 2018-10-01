class CreateOutgoingSlackMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :outgoing_slack_messages do |t|
      t.text :message
      t.boolean :posted_to_slack, null: true
      t.datetime :posted_to_slack_at, null: true
      t.text :slack_message_id, null: true

      t.references :square_cash_fund

      t.timestamps
    end
  end
end
