class RemoveColumnRountFromCampusWinners < ActiveRecord::Migration
  def self.up
    remove_column :campus_winners, :round
  end

  def self.down
    add_column :campus_winners, :round, :string
  end
end
