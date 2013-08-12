ActiveAdmin.register City do

  controller do
    def active_admin_collection
      City.unscoped { super }
    end
    # for show, edit
    def resource
      City.unscoped { super }
    end
  end

 index do
   column :title
   column :slug
   column :lang
   column "description", :text
   default_actions
 end
  form do |f|
    f.inputs :title, :slug, :lang

    f.inputs "Description", :for => [:text, f.object.text || Text.new] do |meta_form|
      meta_form.input :text
      meta_form.input :lang
      meta_form.input :item_type
    end
    f.buttons
  end
end
