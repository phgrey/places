ActiveAdmin.register Place do

  controller do
    def active_admin_collection
      Place.unscoped { super }
    end
    # for show, edit
    def resource
      Place.unscoped { super }
    end
  end


  index do
    column :id
    column :title
    column :lang
    column "Object", :city  do |item|
      City.unscoped { item.city }
    end
    column :city
    default_actions
  end

  form do |f|
    f.inputs "Member Details" do
      #City.unscoped { f.object.city }
      City.unscoped { f.object.city }
      f.input :city
      f.input :title
      f.input :lang
      f.input :latlng
      f.input :contacts, :input_html => { :size => 10 }
      f.input :content, :input_html => { :size => 10 }
    end
  end
end
