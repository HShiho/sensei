class CreateTopicTags < ActiveRecord::Migration[6.1]
  def change
    create_table :topic_tags do |t|
      t.integer :topic_id, null: false, default: ""
      t.integer :tag_id, null: false, default: ""

      t.timestamps
    end
  end
end
