module SessionHelper
	

	def log_in(user)
		session[:user_id] = user.id
	end

	# return user object
	def current_user
		@current_user = User.find_by(id: session[:user_id])
	end

	def authenticate_user
	    if @current_user == nil
	      flash[:notice] = "ログインが必要です"
	      redirect_to("/login")
	    end
  	end
		
	


	def logged_in?
		!current_user.nil?
	end

	def log_out
		session.delete(:user_id)
	end
	
	def current_user?(user)
		current_user == user
	end

	def store_location
		session[:forwarding_url] = request.url
	end

	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end
end
