class AddReferencesToPostTags < ActiveRecord::Migration[6.1]
  def change
    add_reference :post_tags, :user, null: false, foreign_key: true
  end
end
