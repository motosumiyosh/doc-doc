class Book < ApplicationRecord
  validates :isbn, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :author, presence: true, length: { maximum: 255 }
  validates :sales_date, presence: true
  validates :item_price, presence: true
  validates :item_url, presence: true, length: { maximum: 255 }
  validates :large_image_url, presence: true, length: { maximum: 255 }
end
