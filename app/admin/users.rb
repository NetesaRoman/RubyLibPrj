ActiveAdmin.register User do

  permit_params :name, :age, :email, :image
  remove_filter :email
  remove_filter :image

  form do |f|
    f.inputs 'User Details' do
      f.input :name
      f.input :age
      f.input :email
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :age
      row :email
      row :image do |user|
        if user.image.present?
        image_tag(user.image, width: 200, height: 200)
        else
          image_tag('/users/avatarPlaceholder.png', width: 200, height: 200)
        end
      end
      row :created_at
      row :updated_at
    end

    panel 'Reader Card' do
      table_for user.reader_card do
        column :id
        column :card_number
        column :issued_date
        column :expiration_date
      end
    end
  end
  
end
