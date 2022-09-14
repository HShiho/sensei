class RemovePostIdFromPostTags < ActiveRecord::Migration[6.1]
  def change
    remove_column :post_tags, :post_id, :integer, null: false
  end
end
