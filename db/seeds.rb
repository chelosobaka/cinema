# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create!([
  {genre: "биография"},
  {genre: "боевик"},
  {genre: "вестерн"},
  {genre: "военный"},
  {genre: "детектив"},
  {genre: "документальный"},
  {genre: "драма"},
  {genre: "исторический"},
  {genre: "комедия"},
  {genre: "криминал"},
  {genre: "мелодрама"},
  {genre: "мультфильм"},
  {genre: "приключения"},
  {genre: "сериал"},
  {genre: "спорт"},
  {genre: "триллер"},
  {genre: "ужасы"},
  {genre: "фантастика"},
  {genre: "фентези"}
])

  require "json"

    file = File.read(File.join(Rails.root, "db", "lordfilm.json"))
    data = JSON.parse(file)
    data.each do |movie|
      Movie.create(
        global_id:    movie["kp_id"],
        title_ru:     movie["title_ru"],
        title_en:     movie["title_en"],
        year:         movie["year"],
        acter:        movie["actors"].join(", "),
        producer:     movie["producer"],
        country:      movie["country"].join(", "),
        genre:        movie["genre"].join(", "),
        description:  movie["about"],
        image_link:   movie["poster"]
      ) 
      puts "movie created"
    end

User.create!(username: 'admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', blocked: false, admin: true)
