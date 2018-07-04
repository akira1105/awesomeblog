class ApplicationController < ActionController::Base
	# before_action :current_user
	include SessionHelper

	def require_login
			unless logged_in?
				store_location
				flash[:danger] = "Please log in."
				redirect_to login_url
			end
		end
end
