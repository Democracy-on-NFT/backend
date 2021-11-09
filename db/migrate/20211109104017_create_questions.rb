class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :deputy_legislature, null: false, foreign_key: true
      t.integer :kind, limit: 2
      t.string :number
      t.date :date
      t.text :title

      t.timestamps
    end
  end
end
