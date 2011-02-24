class UserController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_active_tab

  def dashboard
    @publishers = Publisher.where(:owner_id => current_user).order('created_at')
  end

  private

  def set_active_tab
    @active_tab = 'dashboard'
  end

end
