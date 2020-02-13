require 'rails_helper'

RSpec.describe 'SendSms', type: :module do
  describe 'Send SMS service' do
    context 'behavior' do
      let(:message_params) { { body: 'Test', receiver_id: 1, admin_user_id: 1 } }
      let(:service) { Twilio::SendSmsService.new(message_params) }

      it 'should return a error message' do
        service_result = service.call
        expect(service_result).to eq(['Receiver must exist'])
      end
    end
  end
end
