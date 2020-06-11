
class Movie < ApplicationRecord

  #before_save :parse_kinopoisk, on: :create
  before_save :add_categories_to_movie, :default_values

  has_and_belongs_to_many :categories, dependent: :destroy

  has_many :line_items, dependent: :destroy
  has_many :favorites, through: :line_items

  validates :global_id, uniqueness: true, presence: true
  validates :title_ru, presence: true
  validates :title_en, presence: true
  validates :country, presence: true
  validates :year, presence: true

  acts_as_votable



  def add_categories_to_movie
    self.genre.downcase!
    self.genre.split(", ").each do |kinopoisk_genre|
      category = Category.find_by(genre: kinopoisk_genre)
      if category.blank?
        next
      end
      unless self.categories.any?{|x| x.genre == category.genre}
        self.categories << category
      end
    end
  end

  def default_values
   self.like ||= 0
   self.dislike ||= 0
  end
=begin private

    def parse_kinopoisk
      film = KpApi::Film.new(self.global_id)
      acter_arr = Array.new
      producer_arr = Array.new

      film.peoples_full.each do |people|
        if people.has_value?("Режиссеры") && producer_arr.size < 5 # поиск режиссёра
          producer_arr << people[:name_ru]
        end
        if people.has_value?("Актеры") && acter_arr.size < 10 # поиск актёров
          acter_arr << people[:name_ru]
        end
      end

      self.title_ru = film.view[:name_ru].downcase if self.title_ru.blank?
      self.title_en = film.view[:name_en].downcase if self.title_en.blank?
      self.country = film.view[:countries].map {|country| %Q(#{country})}.join(", ") if self.country.blank?
      self.genre = film.view[:genres].map {|genre| %Q(#{genre})}.join(", ") if self.genre.blank?
      self.duration = film.view[:duration] if self.duration.blank?
      self.description = film.view[:description] if self.description.blank?
      self.producer = producer_arr.map {|a| %Q(#{a})}.join(", ") if self.producer.blank?
      self.acter = acter_arr.map {|a| %Q(#{a})}.join(", ") if self.acter.blank?
      self.year = film.view[:year] if self.year.blank?
      self.image_link = film.view[:poster_url] if self.image_link.blank?
      self.like = (film.view[:rating_film_critics_vote_count].to_f/100*film.view[:rating_film_critics].to_f).to_i if self.like.blank?
      self.dislike = film.view[:rating_film_critics_vote_count]-(film.view[:rating_film_critics_vote_count].to_f/100*film.view[:rating_film_critics].to_f).to_i if self.dislike.blank?

      film.view[:genres].each do |kinopoisk_genre|
        category = Category.find_by(genre: kinopoisk_genre)
        if category.blank?
          next
        end
        unless self.categories.any?{|x| x.genre == category.genre}
          self.categories << category
        end
      end
    end
end


   :global_id
   :title_ru
   :title_en
   :country
   :genre
   :duration
   :description
   :producer
   :acter
   :year
   :image_link
   :video_link
   :trailer_link
   :like
   :dislike
=end
end
