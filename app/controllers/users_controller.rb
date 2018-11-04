class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  def show
    @user = User.find(params[:id])
    counts(@user)
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def new
    @user = User.new
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end 
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end 
  
  def liked_books
    @user = User.find(params[:id])
    @liked_books = @user.liked_books.page(params[:page])
    counts(@user)
  end 
    
  
  
    
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :birthday, :password_confirmation)
  end
end
