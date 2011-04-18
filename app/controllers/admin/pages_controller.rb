class Admin::PagesController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  before_filter :get_page, :only => [:edit, :update, :destroy]

  load_and_authorize_resource

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    @page.user_id = current_user
    if @page.save
      redirect_to '/pages/%s' % @page.slug,
        :notice => _('Page "%s" has been created.' % @page.title)
    else
      @obj_errors = @page.errors
      render :action => :new
    end
  end

  def show
    if params[:id]
      @page = Page.find(params[:id])
    else
      page = Page.where(:slug => params[:slug])
      if page.size > 0
        @page = page.first
        render :template => 'admin/pages/show'
      else
        @page_not_found = true
        render :template => 'shared/404', :status => 404
      end
    end
  end

  def edit
  end

  def update
    if @page.update_attributes(params[:page])
      redirect_to '/pages/%s' % @page.slug,
        :notice => _('Page "%s" has been updated.' % @page.title)
    else
      @obj_errors = @page.errors
      render :action => :edit
    end
  end

  def destroy
  end

  private

  def get_page
    @page = Page.find(params[:id])
  end
end
