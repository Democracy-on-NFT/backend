class AddAbbreviationToParties < ActiveRecord::Migration[6.1]
  def change
    add_column :parties, :abbreviation, :string
  end
end
