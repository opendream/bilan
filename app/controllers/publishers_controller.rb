class PublishersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_publisher, :only => [:show, :edit, :update, :destroy]
  before_filter :authorize_user!, :only => [:show, :edit, :update, :destroy]

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
      respond_to do |format|
        format.html { redirect_to @publisher, :notice => _('The publisher has been updated.') }
        format.js
      end
    else
      @obj_errors = @publisher.errors
      respond_to do |format|
        format.html { render :action => :edit }
        format.js
      end
    end
  end

  def destroy
  end

  private #--------------------------------------------------------------------

  def get_publisher
    @publisher = Publisher.find(params[:id])  
  end

  def authorize_user!
    if @publisher.owner != current_user
      @access_denied = true
      render :template => 'shared/403'
    end
  end

end
