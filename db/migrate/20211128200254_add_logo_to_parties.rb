class AddLogoToParties < ActiveRecord::Migration[6.1]
  def change
    add_column :parties, :logo, :string
  end
end
