class ChangeIndex < ActiveRecord::Migration
  def change
  	remove_index :weekly_notes, :patient_id
  	add_index :weekly_notes, :patient_id, name: 'index_wn_on_patient_id'
  end
end
