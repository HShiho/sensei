class RemoveForeignKeyTousers < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :post_tags, :users,column: :post_id
    remove_reference :post_tags, :post, index: true
    
    
    add_reference :post_tags, :post, null: false, foreign_key: true
  end
end
