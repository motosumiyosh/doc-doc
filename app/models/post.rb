# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :comment, presence: true, length: { maximum: 255 }
  validates :book, presence: true
  has_many :postships
  has_many :liked_users, through: :postships, source: :user
end
