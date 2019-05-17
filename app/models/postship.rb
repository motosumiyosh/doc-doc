# frozen_string_literal: true

class Postship < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
