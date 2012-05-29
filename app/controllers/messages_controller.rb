class MessagesController < ApplicationController

  before_filter :load_message

  def redirect
    @message.read!

    redirect_to params[:redirect_to]
  end

  def ignore
    # TODO, change this method to mark as read.
    @message.read!

    respond_to do |format|
      format.js { render 'ignore' }
    end
  end

  protected

  def load_message
    @message = Message.find params[:id]
  end
end
