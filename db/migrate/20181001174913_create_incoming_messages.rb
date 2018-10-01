class CreateIncomingMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :incoming_messages do |t|
      t.string :to_country, null: true
      t.string :to_state, null: true
      t.string :sms_message_sid, null: true
      t.string :num_media, null: true
      t.string :to_city, null: true
      t.string :from_zip, null: true
      t.string :sms_sid, null: true
      t.string :from_state, null: true
      t.string :sms_status, null: true
      t.string :from_city, null: true
      t.string :body, null: true
      t.string :from_country, null: true
      t.string :to, null: true
      t.string :to_zip, null: true
      t.string :num_segments, null: true
      t.string :message_sid, null: true
      t.string :account_sid, null: true
      t.string :from, null: true
      t.string :api_version, null: true

      t.boolean :processed, default: false
      t.datetime :processed_at, null: true
      t.text :processing_error, null: true

      t.timestamps
    end
  end
end
