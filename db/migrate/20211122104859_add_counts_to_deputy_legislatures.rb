class AddCountsToDeputyLegislatures < ActiveRecord::Migration[6.1]
  def change
    add_column :deputy_legislatures, :legislative_initiatives_count, :integer
    add_column :deputy_legislatures, :signed_motions_count, :integer
    add_column :deputy_legislatures, :speeches_count, :integer
    add_column :deputy_legislatures, :draft_decisions_count, :integer
    add_column :deputy_legislatures, :questions_count, :integer
  end
end
