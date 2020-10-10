class AddSetNameToRepositoryLoader < ActiveRecord::Migration[5.2]
  def change
    add_column :repository_loaders, :set_name, :string
  end
end
