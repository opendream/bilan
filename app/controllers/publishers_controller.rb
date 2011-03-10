class PublishersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_publisher, :only => [:show, :edit, :update]

  def index
    @publishers = Publisher.where(:owner_id => current_user).order('created_at')
  end

  def create
    @publisher = Publisher.new(params[:publisher])
    @publisher.owner = current_user
    if @publisher.save
      redirect_to @publisher, :notice => _('The publisher has been created.')
    else
      @obj_errors = @publisher.errors
      render :action => :new
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
      @obj_errors = @publisher.errors
      render :action => :edit
    end
  end

  def destroy
  end

  private #--------------------------------------------------------------------

  def get_publisher
    @publisher = Publisher.find(params[:id])  
  end

end
