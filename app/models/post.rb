class Post < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :comment, presence: true, length: {maximum: 255}
  validates :book, presence: true
end
