class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.references :site, index: true, foreign_key: true
      t.string :keywords
      t.date :date
      t.integer :google
      t.integer :google_base_rank
      t.integer :yahoo
      t.integer :bing
      t.integer :global_monthly_searches

      t.timestamps null: false
    end
  end
end
