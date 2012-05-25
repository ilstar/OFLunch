class MessagesController < ApplicationController

  def redirect
    @message = Message.find params[:id]
    @message.read!

    redirect_to params[:redirect_to]
  end
end
