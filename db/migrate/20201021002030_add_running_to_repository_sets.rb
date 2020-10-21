class AddRunningToRepositorySets < ActiveRecord::Migration[5.2]
  def change
    add_column :repository_sets, :running, :boolean
  end
end
