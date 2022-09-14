class RemoveTagIdFromPostTags < ActiveRecord::Migration[6.1]
  def change
    remove_column :post_tags, :tag_id, :integer, null: false
  end
end
