module ApplicationHelper
  def breadcrumb
    separator = " &raquo; "
    render :inline => "Dashboard" + separator
  end
end
