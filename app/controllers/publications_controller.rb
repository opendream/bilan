class PublicationsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_publication, :only => [:show, :edit, :update]
  before_filter :get_publisher, :only => [:new, :create, :edit, :update]
  before_filter :set_active_tab

  def index
  end

  def create
    @publication = Publication.new(params[:publication])
    if @publication.save
      redirect_to publisher_publication_url(@publisher, @publication),
        :notice => _('The publication has been saved.')
    else
      @obj_errors = @publication.errors
      render :action => :new
    end
  end

  def new
    @publication = Publication.new
  end

  def edit
  end

  def show
  end

  def update
    if @publication.update_attributes(params[:publication])
      redirect_to publisher_publication_url(@publisher, @publication),
        :notice => _('The publication has been updated.')
    else
      @obj_errors = @publication.errors
      render :action => :edit
    end
  end

  def destroy
  end

  private

  def get_publication
    @publication = Publication.find(params[:id])
  end

  def get_publisher
    @publisher = Publisher.find(params[:publisher_id])
  end

  def set_active_tab
    @active_tab = 'publisher'
  end

end
