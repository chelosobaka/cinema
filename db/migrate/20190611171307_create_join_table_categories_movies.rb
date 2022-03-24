class CreateJoinTableCategoriesMovies < ActiveRecord::Migration[5.2]
  def change
    create_join_table :categories, :movies do |t|
      t.index %i[category_id movie_id]
      t.index %i[movie_id category_id]
    end
  end
end
