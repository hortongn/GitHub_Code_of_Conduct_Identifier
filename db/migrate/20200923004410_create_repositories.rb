class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.string :login
      t.string :name
      t.string :url
      t.integer :stars
      t.text :description

      t.timestamps
    end
  end
end
