require 'open-uri'
class Download < ActiveRecord::Base
  #attr_accessible :responce, :url
  belongs_to :parsetask

  def self.create_by_url url
    down = create :url => url
    open(down.url){|io|down.responce = io.read}
    down.save
    down.responce
  end
end
