class DistributorsController < ApplicationController
  before_filter :authenticate_user!

  def remote_find_by_name
    @distributor = Distributor.where(['name LIKE ?', params[:term]]).last
    render :json => @distributor
  end
end
