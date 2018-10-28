class User < ApplicationRecord
    
  before_save { self.email.downcase! }
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 255},format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },uniqueness: { case_sensitive: false }
  has_secure_password
    
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow 
  has_many :reversed_of_relationship, class_name:'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reversed_of_relationship,source: :user
  
  has_many :books ,through: :favorites
  
  has_many :favorites
  has_many :liked_books, through: :favorites, source: :book
    
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
    
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
    
  def following?(other_user)
    self.followings.include?(other_user)
  end
    
  def like(book)
    self.favorites.find_or_create_by(book_id: book.id)
  end
  
  def unlike(book)
    favorite = self.favorites.find_by(book_id: book.id)
    favorite.destroy if favorite
  end
  
  def like?(book)
    self.liked_books.include?(book)
  end
  
  
end
