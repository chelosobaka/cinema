class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.integer :global_id
      t.string :title_ru
      t.string :title_en
      t.string :country
      t.string :genre
      t.string :duration
      t.string :description
      t.string :producer
      t.string :acter
      t.string :year
      t.string :image_link
      t.string :video_link
      t.string :trailer_link
      t.integer :like
      t.integer :dislike
      t.timestamps
    end
  end
end
