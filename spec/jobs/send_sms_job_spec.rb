require 'rails_helper'

RSpec.describe SendSmsJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    let!(:receiver) { create(:user) }
    let!(:admin_user) { create(:admin_user) }

    context "without receiver" do
      let(:message_params) { { body: 'Test', receiver_id: 99, admin_user_id: admin_user.id } }
      let(:job) { SendSmsJob.new(message_params) }

      it 'must return receiver error' do
        expect(job.perform_now).to eq(['Receiver must exist'])
      end
    end

    context "without admin_user" do
      let(:message_params) { { body: 'Test', receiver_id: receiver.id, admin_user_id: 99 } }
      let(:job) { SendSmsJob.new(message_params) }

      it 'must return admin_user error' do
        expect(job.perform_now).to eq(['Admin User must exist'])
      end
    end

    context "With correct data" do
      let(:message_params) { { body: 'Test', receiver_id: receiver.id, admin_user_id: admin_user.id } }
      let(:job) { SendSmsJob.new(message_params) }

      it 'must not return nil' do
        expect(job.perform_now).not_to be_nil
      end
    end
  end
end
