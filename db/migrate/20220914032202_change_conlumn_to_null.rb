class ChangeConlumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column :posts, :tomorrow_objective,:string,  null: true
  end

  def down
    change_column :posts, :tomorrow_objective,:string, null: false
  end

end
