class CreateCurrentTerms < ActiveRecord::Migration
  def self.up
    create_table :current_terms do |t|
      t.integer :term_id
      
      
      t.timestamps
    end
  end

  def self.down
    drop_table :current_terms
  end
end
