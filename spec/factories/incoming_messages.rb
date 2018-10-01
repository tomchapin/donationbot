FactoryGirl.define do
  factory :incoming_message do
    to_country 'US'
    to_state 'AZ'
    sms_message_sid 'SM4088b2897498756b26ea6297a2dd63c9'
    num_media '0'
    to_city ''
    from_zip '33136'
    sms_sid 'SM4088b2897498756b26ea6297a2dd63c9'
    from_state 'FL'
    sms_status 'received'
    from_city 'MIAMI'
    body '28581 - message body goes here'
    from_country 'US'
    to '+15555551212'
    to_zip ''
    num_segments '1'
    message_sid 'SM4088b2897498756b26ea6297a2dd63c9'
    account_sid 'AAN83729387sj0383u4b5b7eda48c75caf'
    from '+15555551212'
    api_version '2010-04-01'
    processed false
    processed_at '2018-10-01 10:49:13'
    processing_error 'MyText'
  end
end
