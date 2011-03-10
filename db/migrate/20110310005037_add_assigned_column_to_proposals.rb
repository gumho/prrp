class AddAssignedColumnToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :assigned, :boolean, :default => false
  end

  def self.down
    remove_column :proposals, :assigned
  end
end