class ApplicationController < ActionController::Base

  #before_filter :set_gettext_locale

  layout :layout_by_resource

  protect_from_forgery

  protected

  #def set_gettext_locale
  #  I18n.locale = 'th'
  #end

  def layout_by_resource
    user_signed_in? ? 'application' : 'home'
  end

  def sanitize_page(page)
    page.is_numeric? ? page.to_i : 1
  end

end
