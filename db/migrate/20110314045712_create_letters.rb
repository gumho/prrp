class CreateLetters < ActiveRecord::Migration
  def self.up
    create_table :letters do |t|
      t.string :applicant_organization
      t.string :recommender_name
      t.string :applicant_relation
      t.string :applicant_first_name
      t.string :applicant_last_name
      t.string :content
      t.timestamps
    end
  end

  def self.down
    drop_table :letters
  end
end
