class PublicationsController < ApplicationController

  autocomplete :press, :name
  autocomplete :distributor, :name

  before_filter :authenticate_user!
  before_filter :get_publication, :except => [:index, :create, :new,
                                    :autocomplete_press_name, :autocomplete_distributor_name]
  before_filter :get_publisher
  before_filter :authorize_user!

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

  def update_isbn
    @publication.update_attributes({:isbn => params[:isbn]})
    render :json => @publication
  end

  def update_cip
    @publication.update_attributes({:cip => params[:cip]})
    render :json => @publication
  end

  def export_isbn
    build_pdf('isbn', @publication) 
  end

  def export_cip
    build_pdf('cip', @publication) 
  end

  def print_isbn
    render :template => 'publications/isbn_form_template', :layout => nil
  end

  def print_cip
    render :template => 'publications/cip_form_template', :layout => nil
  end

  private #--------------------------------------------------------------------

  def get_publication
    @publication = Publication.find(params[:id])
    @publication.isbn = @publication.get_isbn
  end

  def get_publisher
    @publisher = Publisher.find(params[:publisher_id])
  end

  def authorize_user!
    if @publisher.owner != current_user
      @access_denied = true
      redirect_to publisher_path @publisher.id
    elsif @publication && @publication.publisher != @publisher
      @access_denied = true
      render :template => 'shared/403'
    end
  end

  def build_pdf(form_type, publication)
    folder = '/tmp/bilan/%s/%s' % [publication.publisher.id, publication.id]
    output_pdf = '%s/%s_request_form.pdf' % [folder, form_type]
    output_html = '%s/%s_request_form.html' % [folder, form_type]
    input_stylesheet = 'public/stylesheets/compiled/print_pdf.css'
    output_stylesheet = '/tmp/bilan/print_pdf.css'
    template = 'app/views/publications/%s_form_template.pdf.slim' % form_type

    # Create a directory
    abs_dir = File.dirname(output_pdf)
    FileUtils.mkdir_p(abs_dir) unless Dir.exist?(abs_dir)

    # Replace font path
    css = File.read(input_stylesheet)
    css.gsub!(/Dir\.pwd/, Dir.pwd)
    File.open(output_stylesheet, 'w') { |f| f.write(css) }

    # Compile a template
    text = Slim::Template.new(template).render(publication)

    File.open(output_html, 'w') { |f| f.write(text) }

    pdf = PDFKit.new(text, :page_size => 'A4')
    pdf.stylesheets << output_stylesheet
    pdf.to_file(output_pdf)

    send_file(output_pdf, :type => 'application/pdf')
    return # to avoid double render call
  end

end
