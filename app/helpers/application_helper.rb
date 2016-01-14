module ApplicationHelper
  def full_title(page_title = "")
    base_title = "Ecom App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # use wildcard routes rather than controller?
  def active_element(controller_or_path)
    return "active" if params[:controller] == controller_or_path
    return "active" if current_page?(controller_or_path)
  end

  def active_nav_link(text, path, controller = nil, html_options = {})
    if current_page?(path) || params[:controller] == controller
      options = { class: "active" }
    end

    content_tag(:li, options) do
      link_to text, path, html_options
    end
  end

  # possible future use
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end
end
