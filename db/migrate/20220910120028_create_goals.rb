class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false, default: ""
      t.string :goal, null: false, default: ""

      t.timestamps
    end
  end
end
