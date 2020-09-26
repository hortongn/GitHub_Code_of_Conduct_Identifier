class RemoveSampleTextFromCodeOfConducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :code_of_conducts, :sample_text, :text
  end
end
