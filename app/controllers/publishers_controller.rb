class PublishersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_publisher, :only => [:show, :edit, :update]
  before_filter :set_active_tab

  def index
    @publishers = Publisher.where(:owner_id => current_user).order('created_at')
  end

  def create
    @publisher = Publisher.new(params[:publisher])
    @publisher.owner = current_user
    if @publisher.save
      redirect_to @publisher, :notice => _('The publisher has been saved.')
    else
      #flash[:alert] = _("Can't save the publisher.")
      redirect_to :action => :new
    end
  end

  def new
    @publisher = Publisher.new
  end

  def edit
  end

  def show
  end

  def update
    if @publisher.update_attributes(params[:publisher])
      redirect_to @publisher, :notice => _('The publisher has been updated.')
    else
      flash[:alert] = _("Can't update the publisher.")
      redirect_to :action => :edit
    end
  end

  def destroy
  end

  private

  def get_publisher
    @publisher = Publisher.find(params[:id])  
  end

  def set_active_tab
    @active_tab = 'publisher'
  end

end
