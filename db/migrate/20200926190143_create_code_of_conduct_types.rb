class CreateCodeOfConductTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :code_of_conduct_types do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
