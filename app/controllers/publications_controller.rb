class PublicationsController < ApplicationController

  autocomplete :press, :name
  autocomplete :distributor, :name

  before_filter :authenticate_user!
  before_filter :get_publication, :only => [:show, :edit, :update, :export_isbn, :export_cip]
  before_filter :get_publisher, :only => [:show, :new, :create, :edit, :update]

  def index
    page = sanitize_page params[:page]
    @publications = Publication.page(page).where(:publisher_id => params[:publisher_id])
  end

  def create
    @publication = Publication.new(params[:publication])
    @publication.publisher = @publisher
    if @publication.save
      redirect_to publisher_publication_url(@publisher, @publication),
        :notice => _('The publication has been created.')
    else
      @obj_errors = @publication.errors
      render :action => :new
    end
  end

  def new
    @publication = Publication.new
    @publication.publisher_name = @publisher.name
    @publication.publisher_name_en = @publisher.name_en
    @publication.publisher_address = @publisher.address
    @publication.publisher_address_en = @publisher.address_en
    @publication.publisher_telephone = @publisher.telephone
    @publication.publisher_fax = @publisher.fax
    @publication.publisher_email = @publisher.email
    @publication.publisher_website = @publisher.website
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
    build_pdf('isbn', @publication) 
  end

  def export_cip
    build_pdf('cip', @publication) 
  end

  private #--------------------------------------------------------------------

  def get_publication
    @publication = Publication.find(params[:id])
    @publication.isbn = @publication.get_isbn
  end

  def get_publisher
    @publisher = Publisher.find(params[:publisher_id])
  end

  def build_pdf(form_type, publication)
    output_file = '/tmp/bilan/%s/%s/%s_requested_form.pdf' %
        [publication.publisher.id, publication.id, form_type]
    template = 'app/views/publications/%s_form_template.html.slim' % form_type

    text = Slim::Template.new(template).render(publication)

    abs_dir = File.dirname(output_file)
    FileUtils.mkdir_p(abs_dir) unless Dir.exist?(abs_dir)

    pdf = PDFKit.new(text, :page_size => 'A4')
    pdf.stylesheets << 'public/stylesheets/compiled/pdf.css'
    pdf.to_file(output_file)

    send_file(output_file, :type => 'application/pdf')
    return # to avoid double render call
  end

end
