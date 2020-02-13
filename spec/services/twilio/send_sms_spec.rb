require 'rails_helper'

RSpec.describe 'SendSms', type: :module do
  describe 'Send SMS service behavior' do
    let!(:receiver) { create(:user) }
    let!(:admin_user) { create(:admin_user) }

    context '' do
      let(:message_params) { { body: 'Test', receiver_id: 1, admin_user_id: 1 } }
      let(:service) { Twilio::SendSmsService.new(message_params) }

      it 'should return a error message' do
        service_result = service.call
        expect(service_result).to eq(['Receiver must exist'])
      end
    end

    context "without receiver" do
      let(:message_params) { { body: 'Test', receiver_id: 99, admin_user_id: admin_user.id } }
      let(:service) { Twilio::SendSmsService.new(message_params) }

      it 'must return receiver error' do
        service_result = service.call
        expect(service_result).to eq(['Receiver must exist'])
      end
    end

    context "without admin_user" do
      let(:message_params) { { body: 'Test', receiver_id: receiver.id, admin_user_id: 99 } }
      let(:service) { Twilio::SendSmsService.new(message_params) }

      it 'must return admin_user error' do
        service_result = service.call
        expect(service_result).to eq(['Admin User must exist'])
      end
    end

    context "With correct data" do
      let(:message_params) { { body: 'Test', receiver_id: receiver.id, admin_user_id: admin_user.id } }
      let(:service) { Twilio::SendSmsService.new(message_params) }

      it 'must not return nil' do
        service_result = service.call
        expect(service_result).not_to be_nil
      end
    end
  end
end
