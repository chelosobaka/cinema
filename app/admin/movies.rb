ActiveAdmin.register Movie do
  filter :categories, collection: proc { Category.all.map { |c| [c.genre, c.id] } }
  filter :global_id
  filter :title_ru
  filter :title_en
  filter :country

  index title: 'Фильмы' do
    selectable_column
    column :id
    column :image_link, sortable: false do |movie|
      if movie.image_link.present?
        image_tag(movie.image_link.to_s, size: '24x24')
      else
        image_tag('head.png', size: '24x24')
      end
    end
    column :title_ru
    column :year
    column :created_at
    column :updated_at
    column do |movie|
      links = []
      links << link_to('Открыть', admin_movie_path(movie.id), action: 'show', id: movie.id)
      links << link_to('Изменить', edit_admin_movie_path(movie.id), action: 'edit', id: movie.id)
      links << link_to('Удалить', admin_movie_path(movie.id), method: :delete)
      links.join(' ').html_safe
    end
  end

  form do |f|
    f.inputs 'Movie Details' do
      f.input :global_id
      f.input :title_ru
      f.input :title_en
      f.input :country, as: :string
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

  permit_params :global_id, :title_ru, :title_en, :country, :genre, :duration, :description, :producer, :acter, :year,
                :image_link, :video_link, :trailer_link, :like, :dislike
  #
  # or
  #
  # permit_params do
  #   permitted = [:global_id, :title_ru, :title_en, :country, :genre, :duration, :description, :producer, :acter, :year, :image_link, :video_link, :trailer_link, :like, :dislike]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
