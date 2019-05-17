# frozen_string_literal: true

class PostshipsController < ApplicationController
  before_action :require_user_logged_in

  def create
    post = Post.find(params[:post_id])
    current_user.post_like(post)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.post_unlike(post)
    redirect_back(fallback_location: root_path)
  end
end
