module ApplicationHelper
  def full_title(page_title)
    base_title = "Cluttered"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def image_url(source)
    URI.join(root_url, image_path(source))
  end
end
