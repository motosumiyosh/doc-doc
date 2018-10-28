class Book < ApplicationRecord
  validates :isbn, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :author, presence: true, length: { maximum: 255 }
  validates :sales_date, presence: true
  validates :item_price, presence: true
  validates :item_url, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum: 255 }
  
  has_many :reversed_of_favorites,class_name:"Favorite",foreign_key:'favorite_id'
  has_many :liked_users, through: :reversed_of_favorites, source: :user
  
end
