class DeleteCounty < ActiveRecord::Migration[6.1]
  def change
    drop_table :counties do |t|
      t.string 'name'
      t.timestamps
    end
  end
end
