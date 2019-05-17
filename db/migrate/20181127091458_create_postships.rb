# frozen_string_literal: true

class CreatePostships < ActiveRecord::Migration[5.0]
  def change
    create_table :postships do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
      t.index %i[user_id post_id], unique: true
    end
  end
end
