class AddElectorColumnToCampusWinners < ActiveRecord::Migration
  def self.up
    add_column :campus_winners, :user_id, :integer
  end

  def self.down
    remove_column :campus_winners, :user_id
  end
end