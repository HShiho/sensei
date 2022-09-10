class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false, default: ""
      t.integer :post_tag_id, null: false, default: ""
      t.integer :achivement, null: false, default: "0"
      t.string :body, null: false, default: ""
      t.string :tomorrow_objective, null: false, default: ""
      t.boolean :is_released, null: false, default: true

      t.timestamps
    end
  end
end
