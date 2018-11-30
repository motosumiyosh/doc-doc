class PostshipsController < ApplicationController
  before_action :require_user_logged_in
  
   def create
    post = Post.find(params[:post_id])
    current_user.like(micropost)
    redirect_to root_url
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unlike(micropost)
    redirect_to root_url
  end
  
end
