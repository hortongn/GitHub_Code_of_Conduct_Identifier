class AddUrlToCodeOfConducts < ActiveRecord::Migration[5.2]
  def change
    add_column :code_of_conducts, :url, :string
  end
end
