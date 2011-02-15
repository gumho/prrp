class AddTermColumnToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :term_id, :integer
  end

  def self.down
    remove_column :proposals, :term_id
  end
end