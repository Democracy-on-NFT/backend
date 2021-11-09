class CreateSpeeches < ActiveRecord::Migration[6.1]
  def change
    create_table :speeches do |t|
      t.text :title
      t.date :date
      t.references :deputy_legislature, null: false, foreign_key: true

      t.timestamps
    end
  end
end
