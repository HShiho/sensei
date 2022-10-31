class CreateObjectives < ActiveRecord::Migration[6.1]
  def change
    create_table :objectives do |t|
      t.integer :goal_id, null: false
      t.integer :period_genre, null: false, default: 0
      t.string :objective, null: false, default: ""
      t.string :did_it, default: ""
      t.string :could_not, default: ""

      t.timestamps
    end
  end
end
