class AddActiveColumnToTerm < ActiveRecord::Migration
  def self.up
    add_column :terms, :active, :boolean
  end

  def self.down
    remove_column :terms, :active
  end
end
