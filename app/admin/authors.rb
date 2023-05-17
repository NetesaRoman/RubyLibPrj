ActiveAdmin.register Author do

  permit_params :name, :image, book_ids: []
  remove_filter :books
  remove_filter :image

  # Определение полей для формы создания/редактирования
  form do |f|
    f.inputs do
      f.input :name
      f.input :image
    end
    f.actions
  end

  # Определение отображения списка авторов
  index do
    selectable_column
    id_column
    column :name
    column :image do |author|
      image_tag(author.image.url, width: 100, height: 100) if author.image.present?
    end
    actions
  end

  # Определение отображения страницы просмотра автора
    show do
      attributes_table do
        row :id
        row :name
        row :image do |author|
          image_tag('/users/avatarPlaceholder.png', width: 200, height: 200) unless author.image.present?
        end
        row :created_at
        row :updated_at
      end

      panel 'Books' do
        table_for author.books do
          column :id
          column :title
          column :genre
          column :biblioteka
        end
      end
    end
  end
  
