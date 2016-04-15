class CreateYoutubeAllTimes < ActiveRecord::Migration
  def change
    create_table :youtube_all_times do |t|
      t.string :title
      t.string :url
      t.string :image_url
      t.string :time
      t.string :viewcount

      t.timestamps null: false
    end
  end
end
