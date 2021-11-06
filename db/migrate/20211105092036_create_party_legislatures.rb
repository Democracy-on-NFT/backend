class CreatePartyLegislatures < ActiveRecord::Migration[6.1]
  def change
    create_table :party_legislatures do |t|
      t.belongs_to :party
      t.belongs_to :legislature

      t.timestamps
    end
  end
end
