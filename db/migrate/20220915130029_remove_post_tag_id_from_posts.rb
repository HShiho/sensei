class RemovePostTagIdFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :post_tag_id, :integer, null: false
  end
end
