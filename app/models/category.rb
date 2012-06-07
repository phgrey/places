class Category < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :title, :parent_id, :slug
end
