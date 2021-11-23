class ChangeStatusTypeToSignedMotions < ActiveRecord::Migration[6.1]
  def up
    change_column :signed_motions, :status, :string
  end

  def down
    # it's not possible to update it back to integer
    change_column :signed_motions, :status, :string
  end
end
