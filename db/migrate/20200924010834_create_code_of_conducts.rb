class CreateCodeOfConducts < ActiveRecord::Migration[5.2]
  def change
    create_table :code_of_conducts do |t|
      t.string :path
      t.text :sample_text
      t.belongs_to :repository, foreign_key: true

      t.timestamps
    end
  end
end
