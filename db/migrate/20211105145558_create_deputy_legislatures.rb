class CreateDeputyLegislatures < ActiveRecord::Migration[6.1]
  def change
    create_table :deputy_legislatures do |t|
      t.belongs_to :deputy
      t.belongs_to :legislature
      t.belongs_to :electoral_circumscription
      t.timestamps
    end
  end
end
