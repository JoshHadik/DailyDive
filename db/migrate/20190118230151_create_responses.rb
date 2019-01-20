class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.string :question
      t.string :body
      t.integer :position
      t.belongs_to :entry, foreign_key: true

      t.timestamps
    end
  end
end
