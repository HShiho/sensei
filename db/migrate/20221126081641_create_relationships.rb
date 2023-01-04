class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false

      t.timestamps
    end
  end

  def change
    create_table :rfollows do |t|
      t.integer :user_id, null: false
      t.integer :follower_id, null: false
      t.timestamps
    end

    drop_table :follows do |t|
      t.integer :user_id, null: false
      t.integer :follower_id, null: false
      t.timestamps
    end
  end
end
