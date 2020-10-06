class AddSetIdToRepositories < ActiveRecord::Migration[5.2]
  def change
    add_reference :repositories, :repository_set, foreign_key: true
  end
end
