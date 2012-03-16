class Social < ActiveRecord::Base
  attr_accessible :provider, :external_id, :user_id, :public
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
      end
      user.email = data[:email] if(data[:email]) && !user.email
      user.photo = data[:photo] if(data[:photo]) && !user.photo
      user.socials_attributes= [auth_attrs]
      user.save(:validate => false)
      user
    end
  end

  protected

  def self.extract_data_from_raw(type, raw)
    data = raw.extra.raw_info
    if type == 'twitter'
      {:id => data.id, :name => data.name, :email => nil, :photo => data.profile_image_url_https}
    elsif type == 'vkontakte'
      {:id => data.uid, :name => "#{data.first_name} #{data.last_name}", :email => nil, :photo => data.photo}
    elsif type == 'facebook'
      {:id => data.id[/[\d]+/], :name => data.name, :email => data.email, :photo => nil}
    elsif type == 'google_oauth2'
      {:id => data.id[/[\d]+/], :name => data.name, :email => data.email, :photo => data.picture}
    elsif type == 'github'
      {:id => data.id, :name => data.name||data.login, :email => data.email||nil, :photo => nil}
    end
  end
end
