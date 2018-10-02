require 'rails_helper'

RSpec.describe TwilioController, type: :controller do
  describe 'POST #receive_sms' do
    before do
      expect_any_instance_of(TwilioController).to receive(:authenticate_api_user!).and_return(true)
    end

    context 'when an sms message is posted' do
      let(:valid_sms_from_twilio) {
        {
            'ToCountry' => 'US',
            'ToState' => 'AZ',
            'SmsMessageSid' => '',
            'NumMedia' => '0',
            'ToCity' => '',
            'FromZip' => '33136',
            'SmsSid' => '',
            'FromState' => 'FL',
            'SmsStatus' => 'received',
            'FromCity' => 'MIAMI',
            'Body' => '28581 - Cash App: Tom Chapin sent you $1 for for donuts.',
            'FromCountry' => 'US',
            'To' => '+15555551212',
            'ToZip' => '',
            'NumSegments' => '1',
            'MessageSid' => '',
            'AccountSid' => '',
            'From' => '+15555551212',
            'ApiVersion' => '2010-04-01',
        }
      }

      it 'saves the new message in the database' do
        post :receive_sms, params: valid_sms_from_twilio, format: :json
        expect(IncomingMessage.count).to eq(1)
      end

      it 'stores the message body' do
        post :receive_sms, params: valid_sms_from_twilio, format: :json
        @resulting_message = IncomingMessage.last
        expect(@resulting_message.body).to eq(valid_sms_from_twilio['Body'])
      end

      it 'marks newly created message as not being processed yet' do
        post :receive_sms, params: valid_sms_from_twilio, format: :json
        @resulting_message = IncomingMessage.last
        expect(@resulting_message.processed).to be(false)
        expect(@resulting_message.processed_at).to be(nil)
      end

      it 'gives the message to the MessageProcessorService and calls #perform on it' do
        mocked_service_object = double
        expect(MessageProcessorService).to receive(:new).with(an_instance_of(IncomingMessage)).and_return(mocked_service_object)
        expect(mocked_service_object).to receive(:perform)
        post :receive_sms, params: valid_sms_from_twilio, format: :json
      end
    end

  end

end
