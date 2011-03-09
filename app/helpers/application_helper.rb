module ApplicationHelper
  def breadcrumbs
    separator = " &raquo; "
    breadcrumbs = []
    breadcrumbs.push(link_to(_('Dashboard'), dashboard_path))

    i18n_words = {
      'publishers' => _('Publishers'),
      'publications' => _('Publications'),
      'new' => _('New'),
      'edit' => _('Edit')
    }

    links = '/'
    elements = request.url.split('/')[3..-1] # exclude PROTOCOL, HOST, PORT
    elements.delete('dashboard') # exclude 'dashboard'
    for i in 0...elements.size
      links += elements[i] + '/'
      if i % 2 == 0 # it may be a Model
        if elements[i] == elements.last
          item = i18n_words.fetch(elements[i]) rescue elements[i].camelize
        else
          text = i18n_words.fetch(elements[i].pluralize) rescue elements[i].pluralize.camelize
          item = link_to(text, links)
        end
        breadcrumbs.push(item)
      else
        begin
          elm_name = elements[i-1].singularize.camelize.constantize.find(elements[i]).name
          if i == elements.size - 1
            item = elm_name
          else
            item = link_to(elm_name, links)
          end
          breadcrumbs.push(breadcrumbs.pop + ': ' + item)
        rescue
          breadcrumbs.push(i18n_words.fetch(elements[i]))
        end
      end
    end
    render :inline => breadcrumbs.join(separator)
  end

end
