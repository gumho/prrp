class CreateCampusWinners < ActiveRecord::Migration
  def self.up
    create_table :campus_winners do |t|
      t.references :proposal
      t.references :term
      t.references :organization
      t.string :round

      t.timestamps
    end
  end

  def self.down
    drop_table :campus_winners
  end
end
