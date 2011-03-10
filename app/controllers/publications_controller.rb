class PublicationsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_publication, :only => [:show, :edit, :update, :export_isbn, :export_cip]
  before_filter :get_publisher, :only => [:show, :new, :create, :edit, :update]

  def index
    @publications = Publication.where(:publisher_id => params[:publisher_id]).order(:created_at)
  end

  def create
    @publication = Publication.new(params[:publication])
    @publication.publisher = params[:publisher_id]
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

  def export_isbn
    export_pdf('isbn', @publication) 
  end

  def export_cip
    export_pdf('cip', @publication) 
  end

  private #--------------------------------------------------------------------

  def get_publication
    @publication = Publication.find(params[:id])
    @publication.isbn = @publication.get_isbn
  end

  def get_publisher
    @publisher = Publisher.find(params[:publisher_id])
  end

  def export_pdf(form_type, publication)
    output_file = '/tmp/bilan/%s/%s/%s_requested_form.pdf' %
      [publication.publisher.id, publication.id, form_type]
    text = build_text(publication)
    build_pdf(output_file, text)
    send_file(output_file, :type => 'application/pdf', :x_sendfile => true)
  end

  def build_text(obj)
    obj.title + '\n' + obj.author
  end

  def build_pdf(output_file, text)
    unless File.exist?(File.dirname(output_file))
      FileUtils.mkdir_p(File.dirname(output_file))
    end
    pdf = Prawn::Document.new
    pdf.font('public/fonts/thsarabun.ttf')
    pdf.text(text)
    pdf.render_file(output_file)
  end

end
