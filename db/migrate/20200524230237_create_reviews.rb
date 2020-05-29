class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :game_title
      t.text :content
      t.integer :user_id
    end
  end
end
