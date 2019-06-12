ActiveAdmin.register Movie do
  permit_params  :global_id, :video_link, :trailer_link, :title_ru, :title_en,
  :country, :genre, :duration, :description, :producer, :acter, :year, :image_link,
  :like, :dislike

  index do
    selectable_column
    id_column
    column :global_id
    column :title_ru
    column :country
    column :year
    column :video_link do |movie|
      if movie.video_link.blank?
        false
      else
        true
      end
    end
    column :trailer_link do |movie|
      if movie.trailer_link.blank?
        false
      else
        true
      end
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :global_id
      f.input :title_ru
      f.input :title_en
      f.input :country, :as => :string
      f.input :genre
      f.input :duration
      f.input :description
      f.input :producer
      f.input :acter
      f.input :year
      f.input :image_link
      f.input :video_link
      f.input :trailer_link
      f.input :like
      f.input :dislike
    end
    f.actions
  end
end

=begin
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
