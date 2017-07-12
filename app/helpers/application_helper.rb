module ApplicationHelper
  # Return full title on a per-page basis
  def full_title page_title = ""
    base_title = t "rails_tutorial_sample_app"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
