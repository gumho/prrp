class ChangeTermDefaults < ActiveRecord::Migration
  def self.up
    change_column_default :terms, :active, false
  end

  def self.down
    change_column_default :terms, :active, false
  end
end