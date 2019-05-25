# frozen_string_literal: true

class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  # validates :password , format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}+\z/i }
  has_secure_password

  validates :bio, length: { maximum: 150 }

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reversed_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reversed_of_relationship, source: :user

  has_many :books, through: :favorites

  has_many :favorites
  has_many :liked_books, through: :favorites, source: :book

  has_many :posts

  has_many :postships, dependent: :destroy
  has_many :like_posts, through: :postships, source: :post

  def post_like(post)
    postships.find_or_create_by(post_id: post.id)
  end

  def post_unlike(post)
    postship = postships.find_by(post_id: post.id)
    postship&.destroy
  end

  def post_liked?(post)
    like_posts.include?(post)
  end

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def like(book)
    favorites.find_or_create_by(book_id: book.id)
  end

  def unlike(book)
    favorite = favorites.find_by(book_id: book.id)
    favorite&.destroy
  end

  def like?(book)
    liked_books.include?(book)
  end

  def feed_posts
    Post.where(user_id: following_ids + [id])
  end
end
