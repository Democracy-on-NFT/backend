class CreateLegislativeInitiatives < ActiveRecord::Migration[6.1]
  def change
    create_table :legislative_initiatives do |t|
      t.string :number
      t.date :date
      t.text :title
      t.references :deputy_legislature, null: false, foreign_key: true

      t.timestamps
    end
  end
end
