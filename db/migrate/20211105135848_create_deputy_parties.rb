class CreateDeputyParties < ActiveRecord::Migration[6.1]
  def change
    create_table :deputy_parties do |t|
      t.belongs_to :deputy
      t.belongs_to :party
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
