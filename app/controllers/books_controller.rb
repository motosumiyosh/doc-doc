# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :require_user_logged_in, only: [:show]

  def new
    @books = []
    @title = params[:title]
    if @title
      results = RakutenWebService::Books::Book.search(
        title: @title,
        hits: 28
      )
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
    count_books(@book)
  end

end
