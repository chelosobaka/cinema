class PagesController < ApplicationController
  def chatter
    @messages = Message.all
    @message = Message.new
  end
end
