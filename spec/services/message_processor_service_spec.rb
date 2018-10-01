require 'rails_helper'

RSpec.describe MessageProcessorService do

  let(:incoming_message) { FactoryGirl.create(:incoming_message) }
  let(:message_processor_service) { MessageProcessorService.new(message) }

  it 'accepts an incoming message as a parameter and sets it as an instance variable' do
    expect(message_processor_service.instance_variable_get(:@incoming_message)).to eq(incoming_message)
  end

  it 'performs' do
    message_processor_service.perform
  end

end