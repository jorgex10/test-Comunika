class SendSmsJob < ApplicationJob
  queue_as :default

  def perform(message_params)
    sms_service = Twilio::SendSmsService.new(message_params)
    sms_service.call
  end
end
