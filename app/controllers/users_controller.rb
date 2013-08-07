class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      flash[:success] = "Welcome to Twitter!"
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end


  def edit
    
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end 

  def correct_user
      @user = User.find(params[:id])
      redirect_to  current_user unless current_user == @user
  end

  def admin_user
    unless current_user.admin?
      redirect_to(root_url)
    end
  end
end
