# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_625_190_141) do
  create_table 'categories', force: :cascade do |t|
    t.string 'genre'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'categories_movies', id: false, force: :cascade do |t|
    t.integer 'category_id', null: false
    t.integer 'movie_id', null: false
    t.index %w[category_id movie_id], name: 'index_categories_movies_on_category_id_and_movie_id'
    t.index %w[movie_id category_id], name: 'index_categories_movies_on_movie_id_and_category_id'
  end

  create_table 'channel_users', force: :cascade do |t|
    t.integer 'channel_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['channel_id'], name: 'index_channel_users_on_channel_id'
    t.index ['user_id'], name: 'index_channel_users_on_user_id'
  end

  create_table 'channels', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.index ['user_id'], name: 'index_channels_on_user_id'
  end

  create_table 'favorites', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.index ['user_id'], name: 'index_favorites_on_user_id'
  end

  create_table 'line_items', force: :cascade do |t|
    t.integer 'movie_id'
    t.integer 'favorite_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'messages', force: :cascade do |t|
    t.integer 'channel_id'
    t.integer 'user_id'
    t.text 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['channel_id'], name: 'index_messages_on_channel_id'
    t.index ['user_id'], name: 'index_messages_on_user_id'
  end

  create_table 'movies', force: :cascade do |t|
    t.integer 'global_id'
    t.string 'title_ru'
    t.string 'title_en'
    t.string 'country'
    t.string 'genre'
    t.string 'duration'
    t.string 'description'
    t.string 'producer'
    t.string 'acter'
    t.string 'year'
    t.string 'image_link'
    t.string 'video_link'
    t.string 'trailer_link'
    t.integer 'like'
    t.integer 'dislike'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'reviews', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'movie_id'
    t.string 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['movie_id'], name: 'index_reviews_on_movie_id'
    t.index ['user_id'], name: 'index_reviews_on_user_id'
  end

  create_table 'user_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.integer 'resource_id'
    t.string 'author_type'
    t.integer 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[author_type author_id], name: 'index_user_comments_on_author_type_and_author_id'
    t.index ['namespace'], name: 'index_user_comments_on_namespace'
    t.index %w[resource_type resource_id], name: 'index_user_comments_on_resource_type_and_resource_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username', default: '', null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.boolean 'blocked', default: false, null: false
    t.boolean 'admin', default: false, null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'voter_sessions', force: :cascade do |t|
    t.string 'session_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'votes', force: :cascade do |t|
    t.string 'votable_type'
    t.integer 'votable_id'
    t.string 'voter_type'
    t.integer 'voter_id'
    t.boolean 'vote_flag'
    t.string 'vote_scope'
    t.integer 'vote_weight'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index %w[votable_id votable_type vote_scope],
            name: 'index_votes_on_votable_id_and_votable_type_and_vote_scope'
    t.index %w[voter_id voter_type vote_scope], name: 'index_votes_on_voter_id_and_voter_type_and_vote_scope'
  end
end
