class CreateYoutubeTodays < ActiveRecord::Migration
  def change
    create_table :youtube_todays do |t|
      t.string :url
      t.string :title
      t.string :image_url
      t.string :time
      t.string :viewcount

      t.timestamps null: false
    end
  end
end
