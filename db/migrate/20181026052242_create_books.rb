# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.date :sales_date
      t.integer :item_price
      t.string :item_url
      t.string :image_url

      t.timestamps
    end
  end
end
