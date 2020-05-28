class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :game_title
      t.text :content
      t.integer :user_id
    end
  end
end
