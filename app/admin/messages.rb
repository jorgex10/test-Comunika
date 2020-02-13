ActiveAdmin.register Message do
  permit_params :body, :receiver_id, :admin_user_id

  actions :all, except: %i[edit update destroy]

  form do |f|
    f.inputs do
      f.input :body
      f.hidden_field :receiver_id
      f.hidden_field :admin_user_id
    end
    f.actions
  end

  controller do
    def new
      @message = Message.new(receiver_id: params[:receiver_id], admin_user_id: current_admin_user.id)
    end

    def create
      SendSmsJob.perform_later(message_params)
      twilio_service.register_local_message

      errors = twilio_service.errors
      if errors.present?
        flash[:error] = errors
        redirect_to admin_users_path
      else
        flash[:success] = 'Message was successfully delivered'
        redirect_to admin_users_path
      end
    end

    private

    def message_params
      params.require(:message).permit(:body, :receiver_id, :admin_user_id)
    end

    def twilio_service
      @twilio_service ||= Twilio::SendSmsService.new(message_params)
    end
  end
end
