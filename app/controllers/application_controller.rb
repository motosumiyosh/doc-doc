class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def count_users(user)
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    
  end 
  def count_books(book)
    @count_liked_users = book.liked_users.count
    @count_posted_users = book.posted_users.count
  end 
    
  #def count(post)
   # @count_posts = user.posts
# end



  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
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
