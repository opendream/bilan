module ApplicationHelper
  def breadcrumb
    separator = " &raquo; "
    breadcrumbs = []
    breadcrumbs.push("<a href=\"%s\">%s</a>" % [dashboard_path, _('Dashboard')])
    elements = request.url.split('/')
    elements[3..-1].each do |elm|
      if elm == elements.last
        item = elm.capitalize
      else
        item = "<a href=\"%s\">%s</a>" % ['x', elm.capitalize]
      end
      breadcrumbs.push(item)
    end
    render :inline => breadcrumbs.join(separator)
    #begin
    #    breadcrumb = ''
    #    so_far = '/'
    #    elements = request.url.split('/')
    #    for i in 1...elements.size
    #    
    #        so_far += elements[i] + '/'
    #        
    #        if elements[i] =~ /^\d+$/
    #            begin
    #                breadcrumb += link_to_if(i != elements.size - 1, eval("#{elements[i - 1].singularize.camelize}.find(#{elements[i]}).name").gsub("_"," ").to_s, so_far)
    #            rescue
    #                breadcrumb += elements[i]
    #            end
    #        else
    #            breadcrumb += link_to_if(i != elements.size - 1,elements[i].gsub("_"," ").titleize, so_far)
    #        end
    #        
    #        breadcrumb += " &raquo; " if i != elements.size - 1
    #    end
    #    breadcrumb
    #rescue
    #    'Not available'
    #end
  end
end
