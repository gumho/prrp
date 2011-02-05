class AddDocColumnToDocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :doc_file_name, :string
  end

  def self.down
    remove_column :documents, :doc_file_name
  end
end