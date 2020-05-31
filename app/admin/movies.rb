ActiveAdmin.register Movie do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   form do |f|
    f.inputs "Movie Details" do
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
  permit_params :global_id, :title_ru, :title_en, :country, :genre, :duration, :description, :producer, :acter, :year, :image_link, :video_link, :trailer_link, :like, :dislike
  #
  # or
  #
  # permit_params do
  #   permitted = [:global_id, :title_ru, :title_en, :country, :genre, :duration, :description, :producer, :acter, :year, :image_link, :video_link, :trailer_link, :like, :dislike]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
