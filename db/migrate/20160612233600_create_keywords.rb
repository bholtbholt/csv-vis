class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.references :site, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
