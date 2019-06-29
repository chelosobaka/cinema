class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.integer :movie_id
      t.integer :favorite_id

      t.timestamps
    end
  end
end
