module Twilio
  class SendSmsService
    require 'twilio-ruby'

    attr_reader :body, :receiver_id, :admin_user_id, :message, :errors

    def initialize(message_params)
      @body = message_params[:body]
      @receiver_id = message_params[:receiver_id]
      @admin_user_id = message_params[:admin_user_id]
      @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
      @message = nil
      @errors = []
    end

    def call
      return errors unless valid?

      send_sms
    end

    def register_local_message
      @message = Message.new(
        body: body,
        receiver_id: receiver_id,
        admin_user_id: admin_user_id
      )
      if @message.save
        @message
      else
        errors << 'Message was not delivered'
        nil
      end
    end

    private

    def valid?
      present_body? &&
        present_receiver? &&
        present_admin_user? &&
        @client
    end

    def send_sms
      @client.messages.create(
        from: '+12015617447',
        to: receiver.contact_number,
        body: body
      )
    end

    def present_body?
      present_body = body.present?
      errors << 'Body can not be empty' unless present_body

      present_body
    end

    def present_receiver?
      errors << 'Receiver must exist' unless receiver

      receiver
    end

    def present_admin_user?
      admin_user = AdminUser.find_by(id: admin_user_id)
      errors << 'Admin User must exist' unless admin_user

      admin_user
    end

    def receiver
      @receiver ||= User.find_by(id: receiver_id)
    end
  end
end
