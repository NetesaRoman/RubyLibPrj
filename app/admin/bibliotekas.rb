ActiveAdmin.register Biblioteka do

  permit_params :name, :address, :phone, :city, :zip_code, :image, book_ids: []
  remove_filter :books
  remove_filter :image
  remove_filter :city
  remove_filter :zip_code

  form do |f|
    f.inputs 'Biblioteka Details' do
      f.input :name
      f.input :address
      f.input :phone
       f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :address
      row :phone
      row :image do |biblioteka|
        if biblioteka.image.present?
          image_tag(biblioteka.image, width: 200, height: 200)
        else
          image_tag('/bibliotekas/lib_template.jpg', width: 200, height: 200)
        end
      end
      row :created_at
      row :updated_at
    end

    panel 'Books' do
      table_for biblioteka.books do
        column :id
        column :title
        # Другие поля книги, которые вы хотите отобразить
      end
    end

    panel 'Reader Cards' do
      table_for biblioteka.reader_cards do
        column :id
        column :card_number
        # Другие поля ридерской карты, которые вы хотите отобразить
      end
    end
  end
  
end
