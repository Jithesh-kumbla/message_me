class MessagesController < ApplicationController
  before_action :require_user
  def create
  	message = current_user.messages.build(message_params)
  	if message.save
  		ActionCable.server.broadcast "chatroom_channel",
  									 body: render_message(message)
  	end
  end

  private

  def require_login
	unless logged_in?
		flash[:error] = "This activity needs you to login to your application"
		redirect_to login_path
	end
  end

  def message_params
  	params.require(:message).permit(:body)
  end

  def render_message(message)
  	render(partial: 'messages/message', locals: {message: message})
  end
end
