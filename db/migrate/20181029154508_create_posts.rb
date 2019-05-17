# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.string :comment

      t.timestamps
      t.index %i[user_id book_id]
    end
  end
end
