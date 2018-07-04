class StaticPagesController < ApplicationController
  def home
  	if logged_in?
      # @microposts = Micropost.where("user_id IN (?)", current_user.following_ids)
      #                               .paginate(page: params[:page], per_page: 10)
  		@microposts = current_user.feed.paginate(page: params[:page])
  		@micropost = current_user.microposts.build
  	end
  end

  def help
  end

  def about
  end

end
