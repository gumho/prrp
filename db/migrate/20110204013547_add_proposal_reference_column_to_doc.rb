class AddProposalReferenceColumnToDoc < ActiveRecord::Migration
  def self.up
    add_column :documents, :proposal_id, :integer
  end

  def self.down
    remove_column :documents, :proposal_id
  end
end