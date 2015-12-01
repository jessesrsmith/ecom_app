module ApplicationHelper
  def full_title(page_title = "")
    base_title = "Ecom App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def active_nav(path)
    current_page?(path) ? "active" : nil
  end
end
