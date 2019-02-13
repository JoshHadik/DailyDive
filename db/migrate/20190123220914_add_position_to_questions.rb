class AddPositionToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :position, :integer
    add_index :questions, [:journal_id, :position], unique: true
  end
end
