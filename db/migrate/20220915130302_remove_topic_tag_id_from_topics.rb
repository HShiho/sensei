class RemoveTopicTagIdFromTopics < ActiveRecord::Migration[6.1]
  def change
    remove_column :topics, :topic_tag_id, :integer, null: false
  end
end
