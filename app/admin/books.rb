ActiveAdmin.register Book do

  permit_params :title, :image, :author_id, :genre_id, :biblioteka_id
  remove_filter :author
  remove_filter :genre
  remove_filter :image

  # Определение полей для формы создания/редактирования
  form do |f|
    f.inputs do
      f.input :title
      f.input :image
      f.input :author
      f.input :genre
      f.input :biblioteka
    end
    f.actions
  end

  # Определение отображения списка книг
  index do
    selectable_column
    id_column
    column :title
    column :image do |book|
      image_tag(book.image.url, width: 100, height: 100) if book.image.present?
    end
    column :author
    column :genre
    column :biblioteka
    actions
  end

  # Определение отображения страницы просмотра книги
  show do
    attributes_table do
      row :id
      row :title
      row :image do |book|
        image_tag(book.image.url, width: 200, height: 200) if book.image.present?
      end
      row :author
      row :genre
      row :biblioteka
      row :created_at
      row :updated_at
    end
  end
  
end
