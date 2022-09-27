class RenameObjectiveColumnToObjectives < ActiveRecord::Migration[6.1]
  def change
    rename_column :objectives, :objective, :title
  end
end
