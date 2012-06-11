class Catting < ActiveRecord::Base
  belongs_to :category, :polymorphic => true
  belongs_to :cattable, :polymorphic => true
end