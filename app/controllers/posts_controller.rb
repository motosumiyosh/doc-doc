class PostsController < ApplicationController
  before_action :require_user_logged_in
  def create
    @book = Book.find(params[:book_id])
    @book.save
    

    @post = current_user.posts.new(post_params)
    @post.book_id = @book.id
    if @post.save
      flash[:success] = '投稿が送信されました'
      redirect_to @post
    else
      flash[:danger] = '投稿の送信に失敗しました'
      render :new
    end
    
  end

  #def destroy
   # @post = Post.find(params[:id])
    #@post.destroy
  #  flash[:success] = '投稿が削除されました'
   # redirect_to user_path
  #end

  def new
    @book = Book.find_or_initialize_by(isbn: params[:book_isbn])
    
    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
   
      
      @book = Book.new(read(results.first))
      @book.save
      
    end
    
    @post = Post.new
    
  end

  def show
    @post = Post.find(params[:id])
    #@book = Book.find(params[:book_id])
  end
  
  private
  
  def post_params
    
    params.require(:post).permit(:comment, :book)
  end
end
