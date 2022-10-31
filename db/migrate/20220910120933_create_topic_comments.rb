class CreateTopicComments < ActiveRecord::Migration[6.1]
  def change
    create_table :topic_comments do |t|
      t.integer :user_id, null: false
      t.integer :topic_id, null: false
      t.string :body, null: false, default: ""

      t.timestamps
    end
  end
end
