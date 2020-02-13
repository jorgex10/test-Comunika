require 'rails_helper'

RSpec.describe SendSmsJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    let!(:message_params) { { body: 'Test', receiver_id: 1, admin_user_id: 1 } }

    subject(:job) { SendSmsJob.new(message_params) }

    it 'execution must return receiver error' do
      expect(job.perform_now).to eq(['Receiver must exist'])
    end
  end
end
