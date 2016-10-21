class MessagesController < ApplicationController
  before_action :require_login
  before_action :init_message, only: [:new, :index, :incoming, :outgoing]

  def new
  end

  def index
  end

  def create
    @recipient = User.find(message_params[:recipient])
    message_params[:sender] = current_user
    message_params[:recipient] = @recipient

    if Conversation.between(current_user.id, @recipient.id).present?
      @conversation = Conversation.between(current_user.id, @recipient.id).first
    else
      @conversation = Conversation.create!(sender: current_user, recipient: @recipient)
    end

    @message = @conversation.messages.build(message_params)

    if @message.save!
      flash.now[:success] = "Successfully send messages"
      # redirect_to incoming_messages_path
    else
      flash.now[:error] = @message.errors.full_messages.to_sentence
    end

    @messages = @conversation.messages
    @messages = @messages.group_by { |message|
      message.created_at.to_date
    }

    respond_to do |format|
      format.html {}
      format.js  {}
    end
  end

  def incoming
  end

  def outgoing
  end

  private
    def message_params
      @message_params ||= params.require(:message).permit(:recipient, :body, :conversation_id)
    end

    def init_message
      @message = Message.new
    end
end
