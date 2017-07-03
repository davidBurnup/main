module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  # Check if object still exists in the database and display a link to it,
  # otherwise display a proper message about it.
  # This is used in activities that can refer to
  # objects which no longer exist, like removed posts.
  def link_to_trackable(object, object_type)
    if object
      link_to object_type.downcase, object
    else
      "a #{object_type.downcase} which does not exist anymore"
    end
  end


  def navigation_link(title, links, icon = "", options = {})

    if links.is_a? Array
      link = links[0]
    else
      link = links
      links = [link]
    end

    icon_wrapper = icon
    if options[:icons] == "fontawesome"
      icon_wrapper = "fa fa-#{icon_wrapper}"
    elsif options[:icons] == "burnup"
      icon_wrapper = "bu-#{icon_wrapper}"
    elsif !options[:icon]
      icon_wrapper = "glyphicon glyphicon-#{icon_wrapper}"
    end
    html = "<li class='#{(links.any?{|any_link| current_page?(any_link)} ? "active" : "")}'>"
    html += link_to raw("<i class='#{icon.present? ? icon_wrapper : ""}'></i>&nbsp;#{title}"), link
    html += "</li>"
    raw html
  end

end
