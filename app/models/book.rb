# frozen_string_literal: true

class Book < ApplicationRecord
  validates :isbn, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :author, length: { maximum: 255 }
  validates :sales_date, presence: true
  validates :item_price, presence: true
  validates :item_url, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum: 255 }

  has_many :favorites
  has_many :liked_users, through: :favorites, source: :user
  has_many :posts
  has_many :posted_users, through: :posts, source: :user
end
