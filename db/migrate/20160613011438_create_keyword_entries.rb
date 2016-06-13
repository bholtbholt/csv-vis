class CreateKeywordEntries < ActiveRecord::Migration
  def change
    create_table :keyword_entries do |t|
      t.references :keyword, index: true, foreign_key: true
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
