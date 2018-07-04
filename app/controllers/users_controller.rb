class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_ueer, only: :destroy

	def index
		@users = User.paginate(page: params[:page], per_page: 15)
	end

	def new
			@user = User.new
	end

	def create
		@user = User.create(user_params)

		if @user.save
			log_in @user

			flash[:success] = "Welcome to Awesome Blog!"
			redirect_to @user
		else
			flash[:danger] = "You have errors."
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.order(created_at: :desc).paginate(page: params[:page], per_page: 15)

	end

	def edit
		# @user = User.find(params[:id])
	end

	def update
		# @user = User.find(params[:id])

		if @user.update_attributes(user_params)
			flash[:success] = "Updated your information successfully."
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		user = User.find(params[:id])
		flash[:info] = "successfully delete user: #{user.email}"
		user.destroy
		
		redirect_to users_url
	end

	def following
		@user = User.find(params[:id])
		@users = @user.following
		@title = "Following"
		render 'show_follow'
		# @users = @user.following
      	# @microposts = Micropost.where("user_id IN (?)", current_user.following_ids)
      	#                               .paginate(page: params[:page], per_page: 10)
  		# @microposts = current_user.feed.paginate(page: params[:page])
  		# @micropost = current_user.microposts.build
  	end

  	def followers
  		@user = User.find(params[:id])
  		@users = @user.followers
  		@title = "Follower"
  		render 'show_follow'
  	end
  

	

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		

		def correct_user
			@user = User.find(params[:id])

			unless current_user?(@user)
				flash[:danger] = "You are not allowed here."
				redirect_to root_url
			end
		end

		def admin_user
			unless current_user.admin?
				flash[:danger] = "You are not allowed to do that."
				redirect_to root_url
			end
			
		end
end
