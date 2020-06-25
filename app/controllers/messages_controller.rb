class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel

  def create
    @message = Message.create(user: current_user, channel: @channel, body: message_params[:body])
  end


  private

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end
  def message_params
    params.require(:message).permit(:body)
  end
end
