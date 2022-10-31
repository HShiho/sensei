class AddIsCompletedToGoals < ActiveRecord::Migration[6.1]
  def change
    add_column :goals, :is_completed, :integer, null: false, default: 0
  end
end
