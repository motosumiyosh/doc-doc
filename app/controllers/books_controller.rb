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
        book = Book.new(read(result))
        @books << book
      end
    end
        
    
  end

  def show
    @book = Book.find(params[:id])
  end
  
  private
  
  def read(result)
    isbn = result['isbn']
    title = result['title']
    author = result['author']
    sales_date = result['salesDate']
    item_price = result['itemPrice']
    item_url = result['itemUrl']
    image_url = result['largeImageUrl'].gsub('?_ex=300x300z', '')
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
