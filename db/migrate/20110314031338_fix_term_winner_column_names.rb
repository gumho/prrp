class FixTermWinnerColumnNames < ActiveRecord::Migration
  def self.up
    rename_column :term_winners, :terms_id, :term_id
    rename_column :term_winners, :proposals_id, :proposal_id
  end

  def self.down
    rename_column :term_winners, :term_id, :terms_id
    rename_column :term_winners, :proposal_id, :proposals_id
  end
end