class BooksController < ApplicationController

  before_filter :authenticate_user!
  #before_filter :get_publisher, :only => [:show, :edit, :update]
  before_filter :set_active_tab

  def index
  end

  def create
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def set_active_tab
    @active_tab = 'publisher'
  end

end
