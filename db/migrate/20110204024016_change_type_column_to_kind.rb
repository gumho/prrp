class ChangeTypeColumnToKind < ActiveRecord::Migration
  def self.up
    rename_column :documents, :type, :kind
  end

  def self.down
    rename_column :documents, :kind, :type
  end
end