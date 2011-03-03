class AddAwardCategoryColumnToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :award_category_id, :integer
  end

  def self.down
    remove_column :proposals, :award_category_id
  end
end