
class Users::HabredsController < ApplicationController
  before_filter :authenticate_user!


  def edit
    @user = current_user
    @code = @user.get_code
  end

  def update
    if(current_user.set_habred(params[:user][:habred], params[:user][:name]))
      redirect_to current_user, :notice =>  I18n.t('I_am_from_habr.messages.success_' + (params[:user][:habred] ? 'on' : 'off'), :name => params[:user][:name])
    else
      @user = current_user
      flash[:notice] = I18n.t 'I_am_from_habr.messages.errors'
      render 'edit'
    end
  end
end
