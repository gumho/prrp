class CreateTermWinners < ActiveRecord::Migration
  def self.up
    create_table :term_winners do |t|
      t.references :terms
      t.references :proposals
      t.timestamps
    end
  end

  def self.down
    drop_table :term_winners
  end
end
