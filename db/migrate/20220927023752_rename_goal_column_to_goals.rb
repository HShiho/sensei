class RenameGoalColumnToGoals < ActiveRecord::Migration[6.1]
  def change
    rename_column :goals, :goal, :title
  end
end
