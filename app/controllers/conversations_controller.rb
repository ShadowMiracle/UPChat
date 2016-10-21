class ConversationsController < ApplicationController
  layout false

  def show
    if params[:id].nil?
      @conversation = Conversation.create!(sender_id: params[:sender_id], recipient_id: params[:recipient_id])
    else
      @conversation = Conversation.find(params[:id])
    end

    @recipient = interlocutor(@conversation)
    @messages = @conversation.messages

    @messages = @messages.group_by { |message|
      message.created_at.to_date
    }

    respond_to do |format|
      format.html {}
      format.js  {}
    end
  end

  def mark_as_read
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
    @messages.each do |message|
      if !message.read? && current_user == message.recipient
        message.mark_as_read!
      end
    end
  end

  private
    def interlocutor(conversation)
      current_user == conversation.recipient ? conversation.sender : conversation.recipient
    end
end
