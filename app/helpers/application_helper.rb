module ApplicationHelper
  def full_title(page_title = "")
    base_title = "Ecom App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def active_nav_link(text, path, controller = nil, html_options = {})
    if current_page?(path) || params[:controller] == controller
      options = { class: "active" }
    end

    content_tag(:li, options) do
      link_to text, path, html_options
    end
  end
end
