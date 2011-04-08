module ApplicationHelper
  def breadcrumbs
    separator = " <span class=\"cls-separator\">&raquo;</span> "
    breadcrumbs = []
    item = '<span class="dashboard">'.html_safe <<
           link_to(_('Dashboard'), user_root_path) <<
           '</span>'.html_safe
    breadcrumbs.push(item)

    i18n_words = {
      'publishers' => _('Publishers'),
      'publications' => _('Publications'),
      'new' => _('New'),
      'edit' => _('Edit')
    }

    links = '/'
    elements = request.url.split('/')[3..-1] # exclude PROTOCOL, HOST, PORT
    elements.delete('dashboard') # exclude 'dashboard'
    if elements.size > 0
      elements[elements.size - 1] = elements.last.split('?')[0] # remove GET params
    end
    for i in 0...elements.size
      links += elements[i] + '/'
      if i % 2 == 0 # as RESTful, it may be a model name
        if elements[i] == elements.last
          item = i18n_words.fetch(elements[i]) rescue elements[i].camelize
          css_cls = 'active'
        else
          text = i18n_words.fetch(elements[i].pluralize) rescue elements[i].pluralize.camelize
          item = link_to(text, links)
          css_cls = 'cls-link'
        end
        item = "<span class=\"#{css_cls}\">".html_safe << item << "</span>".html_safe
      else
        begin
          elm_name = elements[i - 1].classify.constantize.find(elements[i]).name
          if i == elements.size - 1 # last member of the Array
            if @access_denied
              item = _('Access denied')
            else
              item = elm_name
            end
            css_cls = 'active'
          else
            item = link_to(elm_name, links)
            css_cls = 'obj-link'
          end
          item = "<span class=\"#{css_cls}\">".html_safe << item << "</span>".html_safe
          item = breadcrumbs.pop << '<span class="obj-separator">:</span> '.html_safe << item
        rescue
          item = i18n_words.fetch(elements[i])
          item = '<span class="active">'.html_safe << item << '</span>'.html_safe
        end
      end
      breadcrumbs.push(item)
    end
    render :inline => breadcrumbs.join(separator)
  end

  def more_link_text
    "#{_('more')} &raquo;".html_safe
  end
end
