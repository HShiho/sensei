class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.integer :tag_id, null: false
      t.integer :post_id, null: false

      t.timestamps
    end
    add_index :post_tags, :post_id, name: :index_post_tags_on_post_id
    add_index :post_tags, :tag_id, name: :index_post_tags_on_tag_id
  end
end

