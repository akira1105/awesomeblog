class SessionController < ApplicationController

  # before_action :authenticate_user

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email])
  	
  	if user && user.authenticate(params[:session][:password])
  		# Creating the session for user_id
  		log_in user

  		flash[:success] = "You have successfully logged in."

		  redirect_back_or user
	else
		flash[:danger] = "You have errors."
		render 'new'
  	end
  end

  def destroy
  	log_out

  	flash[:into] = "You successfully logged out."
  	redirect_to root_url
  end
end
