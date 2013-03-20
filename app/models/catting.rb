class Catting < ActiveRecord::Base
  belongs_to :category
  belongs_to :cattable, :polymorphic => true
end