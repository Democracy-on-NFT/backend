class CreateSignedMotions < ActiveRecord::Migration[6.1]
  def change
    create_table :signed_motions do |t|
      t.text :title
      t.string :number
      t.date :date
      t.integer :status, limit: 2
      t.references :deputy_legislature, null: false, foreign_key: true

      t.timestamps
    end
  end
end
