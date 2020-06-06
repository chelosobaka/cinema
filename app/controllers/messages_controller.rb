class MessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.save
    respond_to do |format|
       format.js
      end
  end

  private
  def message_params
    params.require(:message).permit(:body)
  end
end
