# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

#devise user creation
#users = User.create(
#    [
#        {:email => 'nnn@gmail.com', :password => 'foobar', :password_confirmation => 'foobar', :name => 'Omygod'},
#        {:email => 'ololo@gmail.com', :password => 'foobar', :password_confirmation => 'foobar', :name => 'Ololo'},
#    ]
#)
#tags = Tag.create([{:name => 'php'}, {:name => 'ruby'}, {:name => 'js'}, {:name => 'design'} ])
#
#offers = Offer.create([
#      {:description => 'first random offer', :hours => 3, :user => User.last, :tags => Tag.where('name in ("js", "php")')},
#      {:description => 'second random offer', :hours => 8, :user => User.first, :tags => Tag.where('name in ("js", "ruby")')}
#])

#list = %w[tag1, tag2, python, django, rails, highload]
#list.each do |tag|
#  tag2 = ActsAsTaggableOn::Tag.new(:name => tag).save
#  offers = Offer.order('RAND()').limit(10)
#  offers.each {|offer|
#    offer.tag_list+= [tag]
#    offer.save
#  }
#end

#of = Offer.first
#Text.create(:text => 'Here we are! This is our first localized offer!', :lang => 'en', :item_id => of.id)
#Text.create(:text => 'Итак, вот наш первый мультиязычный оффер', :lang => 'ru', :item_id => of.id)



