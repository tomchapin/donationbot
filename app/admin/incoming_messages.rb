ActiveAdmin.register IncomingMessage do

  permit_params :to_country,
                :to_state,
                :sms_message_sid,
                :num_media,
                :to_city,
                :from_zip,
                :sms_sid,
                :from_state,
                :sms_status,
                :from_city,
                :body,
                :from_country,
                :to,
                :to_zip,
                :num_segments,
                :message_sid,
                :account_sid,
                :from,
                :api_version

end
