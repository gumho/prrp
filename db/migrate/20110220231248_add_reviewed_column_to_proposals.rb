class AddReviewedColumnToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :reviewed, :boolean, :default => false
  end

  def self.down
    remove_column :proposals, :reviewed
  end
end