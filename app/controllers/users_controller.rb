class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
    @posts = @user.posts
	end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user 
  		redirect_to @user 
  	else
  		render 'new'
  	end
  end

  def index
    if logged_in?
      @users = User.all
      render 'index'
    else
      redirect_to signup_path
    end
  end

   def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers 
    render 'show_follow'
  end




  private

  	def user_params
  		params.require(:user).permit(:username, :email, :password,
  																	:password_confirmation)
  	end

    # Before filters

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    
end
