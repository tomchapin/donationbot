FactoryGirl.define do
  factory :outgoing_slack_message do
    message "MyText"
    posted_to_slack false
    posted_to_slack_at "2018-10-01 10:49:31"
    slack_message_id "MyText"
  end
end
