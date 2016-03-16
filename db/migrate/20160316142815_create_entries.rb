class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.datetime :published
      t.integer :fblikes
      t.string :url
      t.string :author
      t.integer :feed_id

      t.timestamps null: false
    end
  end
end
