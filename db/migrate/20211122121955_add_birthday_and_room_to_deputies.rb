class AddBirthdayAndRoomToDeputies < ActiveRecord::Migration[6.1]
  def change
    add_column :deputies, :room, :integer, limit: 2
    add_column :deputies, :date_of_birth, :date
  end
end
