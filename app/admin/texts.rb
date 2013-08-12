ActiveAdmin.register Text do

  controller do
    def active_admin_collection
      Text.unscoped { super }
    end
    # for show, edit
    def resource
      Text.unscoped { super }
    end
  end

  index do
    column :text
    column :lang
    column "Object", :item do |item|
      City.unscoped { item.item }
    end
    column :item
    default_actions
  end
end
