class RemoveTopicIdFromTopicTag < ActiveRecord::Migration[6.1]
  def change
    remove_column :topic_tags, :tag_id, :integer, null: false
    remove_column :topic_tags, :topic_id, :integer, null: false
    # remove_column :post_tags, :post_tag_id, :integer, null: false

    add_reference :topic_tags, :tag, null: false, foreign_key: true
    add_reference :topic_tags, :topic, null: false, foreign_key: true
  end
end
