class ChatroomsController < ApplicationController
	before_action :require_login
	def index 
		@messages = Message.all
		@message = Message.new
	end

	private

	def require_login
		unless logged_in?
			flash[:error] = "This activity needs you to login to your application"
			redirect_to login_path
		end
	end
end