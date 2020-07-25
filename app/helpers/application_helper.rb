module ApplicationHelper
  def active_class(name)
    return 'active' if name == controller_name
  end
end
