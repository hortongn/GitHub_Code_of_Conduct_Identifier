class AddFingerprintsToCodeOfConductTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :code_of_conduct_types, :fingerprint_1, :text
    add_column :code_of_conduct_types, :fingerprint_2, :text
  end
end
