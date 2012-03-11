class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name,
          :offers_attributes, :authentications_attributes, :authentications
  has_many :offers
  accepts_nested_attributes_for :offers
  has_many :socials
  accepts_nested_attributes_for :socials
end
