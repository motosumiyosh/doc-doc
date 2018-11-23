class BooksController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @books = []
    
    @title = params[:title]
    if @title
      results = RakutenWebService::Books::Book.search({
        title: @title,
        hits: 28,
      })
      
      results.each do |result|
        book = Book.find_or_initialize_by(read(result))
        @books << book
      end
    end
        
    
  end

  def show
    @book = Book.find(params[:id])
    @liked_users = @book.liked_users
    @posted_users = @book.posted_users
  end
  
  private
  
  def read(result)
    isbn = result['isbn']
    title = result['title']
    author = result['author']
    sales_date = result['salesDate']
    
    
    if sales_date.include?('日') && sales_date.include?('月')
      sales_date = Date.strptime(sales_date, "%Y年%m月%d日")
    elsif sales_date.include?('月')
      sales_date = Date.strptime(sales_date, "%Y年%m月")
    else
      sales_date = Date.strptime(sales_date, "%Y年")
    end
    
    item_price = result['itemPrice']
    item_url = result['itemUrl']
    image_url = result['largeImageUrl'].gsub('?_ex=300x300', '')

    {
      isbn: isbn,
      title: title,
      author: author,
      sales_date: sales_date,
      item_price: item_price,
      item_url: item_url,
      image_url: image_url,
    }
 
  end
  
end
