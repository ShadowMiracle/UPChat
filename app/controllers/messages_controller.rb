class MessagesController < ApplicationController
  before_action :require_login

  def new
    @message = Message.new
  end

  def index
  end

  def create
    message_params[:sender] = current_user
    message_params[:recipient] = User.find(message_params[:recipient])
    @message = Message.create(message_params)

    if @message.save
      flash.now[:success] = "Successfully send messages"
      redirect_to incoming_messages_path
    else
      flash.now[:error] = @message.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def mark_as_read
    @message = Message.find params[:id]
    if !@message.read? && current_user == @message.recipient
      @message.mark_as_read!
    end
  end

  def incoming
  end

  def outgoing
  end

  private
    def message_params
      @message_params ||= params.require(:message).permit(:recipient, :body)
    end
end
