class CreateLegislatures < ActiveRecord::Migration[6.1]
  def change
    create_table :legislatures do |t|
      t.date :start_date
      t.date :end_date
      t.string :title

      t.timestamps
    end
  end
end
