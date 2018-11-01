class PostsController < ApplicationController
  before_action :require_user_logged_in
  def create
    
    @book = Book.find_or_initialize_by(isbn: params[:book_isbn])
    
    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
   
      
      @book = Book.new(read(results.first))
      @book.save
      redirect_to new_post_path
    end
      
   
    
    
    @post = current_user.post.new(post_params)
    
    if @post.save
      flash[:success] = '投稿が送信されました'
      redirect_to @post
    else
      flash[:danger] = '投稿の送信に失敗しました'
      render root_path
    end
    
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿が削除されました'
    redirect_to user_path
  end

  def new
    @post = Post.new
  end

  def show
  end
  
  private
  
  def message_params
    params.require(:post).permit(:comment, :book)
  end
end
