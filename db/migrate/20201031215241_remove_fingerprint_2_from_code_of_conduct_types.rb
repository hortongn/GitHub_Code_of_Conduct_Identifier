class RemoveFingerprint2FromCodeOfConductTypes < ActiveRecord::Migration[5.2]
  def change
    remove_column :code_of_conduct_types, :fingerprint_2, :text
  end
end
