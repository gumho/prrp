class AddEmailColumnToLetters < ActiveRecord::Migration
  def self.up
    add_column :letters, :recommender_email, :string
  end

  def self.down
    remove_column :letters, :email
  end
end