class CreateDeputies < ActiveRecord::Migration[6.1]
  def change
    create_table :deputies do |t|
      t.string :name
      t.string :image_link
      t.string :email

      t.timestamps
    end
  end
end
