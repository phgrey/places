#require 'active_record_handlersocket'

class TestController < ApplicationController


  def index
    require 'handlersocket'
    h = HandlerSocket.new(:host => '127.0.0.1', :port => '9998')

# open PRIMARY index on widgets.user table, assign it ID #1
    h.open_index(1, 'cowork', 'users', 'PRIMARY', 'id,name,email')

# fetch record from index ID 1, where PRIMARY key is equal to 1
    @user = h.execute_single(1, '>', [0], 10)
#    @user = h.find(1, )
# > [0, [["Ilya", "ilya@igvita.com", "2010-01-01 00:00:00"]]]

# open 'id_created' index on widgets.user table, assign it ID #2
#    p h.open_index(2, 'widgets', 'user', 'id_created', 'user_name,user_email,created')

# fetch record from index ID 2, where id >= 2, and date >= 2010-01-03
#    p h.execute_single(2, '>=', [2, '2010-01-03'], 10)
# > [0, [["Bob", "bob@example.com", "2010-01-03 00:00:00"]]]
  end

  def show
    #ActiveRecord::Base.use_handlersocket '127.0.0.1', 9998
    id = params[:id]
    @offer = Offer.find(id)
    @id = @offer.id
    @desc = @offer.description
  end

end
