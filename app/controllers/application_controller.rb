class ApplicationController < ActionController::Base

  #before_filter :set_gettext_locale

  protect_from_forgery

  #def set_gettext_locale
  #  I18n.locale = 'th'
  #end

end
