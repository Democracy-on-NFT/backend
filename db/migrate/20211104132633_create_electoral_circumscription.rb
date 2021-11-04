class CreateElectoralCircumscription < ActiveRecord::Migration[6.1]
  def change
    create_table :electoral_circumscriptions do |t|
      t.string :county_name
      t.integer :number

      t.timestamps
    end
  end
end
