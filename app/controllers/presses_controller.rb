class PressesController < ApplicationController
  before_filter :authenticate_user!

  def remote_find_by_name
    @press = Press.where(['name LIKE ?', params[:term]]).last
    render :json => @press
  end
end
