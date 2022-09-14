class AddReferencesToPostTags2 < ActiveRecord::Migration[6.1]
  def change
    add_reference :post_tags, :tag, null: false, foreign_key: true
  end
end
