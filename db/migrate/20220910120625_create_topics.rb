class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.integer :user_id, null: false, default: ""
      t.integer :topic_tag_id, null: false, default: ""
      t.string :title, null: false, default: ""

      t.timestamps
    end
  end
end
