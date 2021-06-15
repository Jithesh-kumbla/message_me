class SessionsController < ApplicationController
	before_action :define_looged_in_redirect, only: [:new, :create]
	def new

	end

	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = "User logged In Successfully"
			redirect_to root_path
		else
			flash.now[:error] = "Incorrect Username/Password"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "Logged out Successfully"
		redirect_to login_path
	end

	private

	def define_looged_in_redirect
		if logged_in?
			flash[:error] = "You have already logged in"
			redirect_to root_path
		end
	end
end