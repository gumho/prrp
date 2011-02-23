class ChangeTermsToHaveBeginningEndDate < ActiveRecord::Migration
  def self.up
    remove_column :terms, :year
    add_column :terms, :begin, :date
    add_column :terms, :end, :date
  end

  def self.down
    remove_column :terms, :end
    remove_column :terms, :begin
    add_column :terms, :year, :integer
  end
end