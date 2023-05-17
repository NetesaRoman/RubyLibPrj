ActiveAdmin.register Genre do
  permit_params :name, book_ids: []
  remove_filter :books
  form do |f|
    f.inputs do
      f.input :name
      f.input :books, as: :check_boxes, collection: Book.all
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :books_count do |genre|
      genre.books.count
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :books_count do |genre|
        genre.books.count
      end
      row :created_at
      row :updated_at
    end
  end
end
