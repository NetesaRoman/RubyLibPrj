ActiveAdmin.register ReaderCard do

  permit_params :user_id, :biblioteka_id, :date_issued, :date_expired

  form do |f|
    f.inputs 'Reader Card Details' do
      f.input :user
      f.input :biblioteka
      f.input :date_issued, as: :datepicker
      f.input :date_expired, as: :datepicker
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :biblioteka
      row :date_issued
      row :date_expired
      row :created_at
      row :updated_at
    end
  end
  
end
