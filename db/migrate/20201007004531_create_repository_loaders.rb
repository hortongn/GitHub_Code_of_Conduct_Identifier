class CreateRepositoryLoaders < ActiveRecord::Migration[5.2]
  def change
    create_table :repository_loaders do |t|
      t.text :repository_list

      t.timestamps
    end
  end
end
