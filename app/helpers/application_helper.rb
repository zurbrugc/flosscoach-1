module ApplicationHelper
  SITE_NAME = "FLOSScoach"

  def site_name
    SITE_NAME
  end
  def grid_stack_wrapper(&block)
    content = "<div class='grid-stack' data-plugin='gridstack'>".html_safe
    content << capture(&block)
    content << "</div>".html_safe
    content.html_safe
    concat(content)
  end
  def create_modal(title, id, &block)
    content = "<div class='modal fade' id='#{id}' aria-labelledby='#{id}' role='dialog' tabindex='-1' style='display: none;'>"
    content << "<div class='modal-dialog modal-lg'>"
    content << "<div class='modal-content'>"

    content << "<div class='modal-header'>"
    content << "<button type='button' class='close' data-dismiss='modal'>"
    content << "<span>×</span>"
    content << "</button>"
    content << "<h4 class='modal-title' id='exampleOptionalLarge'>#{title}</h4>"
    content << "</div>"

    content << "<div class='modal-body'>"
    content << capture(&block)
    content << "</div>"

    content << "</div>"
    content << "</div>"
    content << "</div>"
    concat(content.html_safe)
  end

end
