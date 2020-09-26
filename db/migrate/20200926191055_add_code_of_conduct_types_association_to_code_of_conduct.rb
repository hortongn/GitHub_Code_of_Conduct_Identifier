class AddCodeOfConductTypesAssociationToCodeOfConduct < ActiveRecord::Migration[5.2]
  def change
    add_column :code_of_conducts, :code_of_conduct_type_id, :integer
    add_index 'code_of_conducts', ['code_of_conduct_type_id'], :name => 'index_code_of_conducts_on_code_of_conduct_type_id'
  end
end
