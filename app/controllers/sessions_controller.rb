class SessionsController < ApplicationController
  def new
  end

  def create
	user = User.find_by_name(params[:name])
	if user && user.authenticate(params[:password])
		session[:user_id] = user.id
		redirect_to user
	else
		flash.now[:error] = "Invalid name/password, no match"
		render 'new'
	end
  end

  def destroy
	if logged_in?
		session[:user_id] = nil
	else
		flash[:notice] = "You need to login"
	end
	redirect_to login_path
  end
end
