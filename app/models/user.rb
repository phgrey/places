require "md5"

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :options,
      :send_me_email, :lang,
      :offers_attributes, :socials_attributes, :texts, :texts_attributes


  #after_initialize :init

  has_many :offers
  accepts_nested_attributes_for :offers

  has_many :socials
  accepts_nested_attributes_for :socials, :allow_destroy => true

  has_many :texts, :foreign_key => 'item_id', :conditions => {:item_type => 'User'}, :inverse_of => :user
  accepts_nested_attributes_for :texts

  def init
    self.texts = Text.new_for_each_locale('User') unless self.texts.count > 0
    self.lang = I18n.locale  unless self.lang.to_s.length > 0
  end

  def save(*)
    if new_record? && (self.texts.count == 0)
      self.texts = Text.new_for_each_locale('User')
    end
    if new_record? && (self.lang == nil)
      self.lang = I18n.locale
    end
    super
  end

  # Update record attributes when :current_password matches, otherwise returns
  # error on :current_password. It also automatically rejects :password and
  # :password_confirmation if they are blank.
  def update_with_password(params, *options)
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if !current_password || valid_password?(current_password)
               update_attributes(params, *options)
             else
               self.attributes = params
               self.valid?
               self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
               false
             end

    clean_up_passwords
    result
  end

  def send_me_email
    options&1
  end

  def send_me_email=(flag)
    self.options&=(510+flag.to_i)
  end

  def email=(new_email)
    super
    hash = MD5::md5(new_email.downcase).to_s
    self.photo||='http://www.gravatar.com/avatar/'+ hash + '.jpg'
  end

end
