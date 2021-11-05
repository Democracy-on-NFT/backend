class AddDeputyReferenceToOffices < ActiveRecord::Migration[6.1]
  def change
    add_reference :offices, :deputy, foreign_key: true
  end
end
