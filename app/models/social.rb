Aclass Social < ActiveRecord::Base
  attr_accessible :provider, :external_id, :user_id
  belongs_to :user

  def self.find_for(type, access_token, user=nil)
    data = extract_data_from_raw(type, access_token)
    auth_attrs = {:provider => type, :external_id => data[:id]}
    auth = where(auth_attrs).first
    if(auth)
      auth.user
    else
      if (data[:email] == nil || !(ube = User.where(:email => data[:email] ).first) )
         user||=  User.new(:name => data[:name], :email => data[:email], :password => Devise.friendly_token[0,20])
      else
        user = ube

      user.email = data[:email] if(data[:email] != nil) && (user.email == nil)
      user.socials_attributes= [auth_attrs]
      user.save(:validate => false)
      user
    end
  end

  protected

  def self.extract_data_from_raw(type, raw)
    data = raw.extra.raw_info
    if type == 'twitter'
      {:id => data.id, :name => data.name, :email => nil}
    elsif type == 'vkontakte'
      {:id => data.uid, :name => "#{data.first_name} #{data.last_name}", :email => nil}
    elsif type == 'facebook'
      {:id => data.id[/[\d]+/], :name => data.name, :email => data.email}
    elsif type == 'google_oauth2'
      {:id => data.id[/[\d]+/], :name => data.name, :email => data.email, :photo => data.picture}
    elsif type == 'github'
      {:id => data.id, :name => data.name||data.login, :email => data.email||nil}
    end
  end
end
