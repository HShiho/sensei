class RenameUserIdColumnToPostTags < ActiveRecord::Migration[6.1]
  def change
    rename_column :post_tags, :user_id, :post_id
  end
end
