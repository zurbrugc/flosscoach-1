module ProjectViewHelper

  def tab_pane(id, active:false,  gridstack: true, &block)
    content = "<div class='tab-pane #{"grid-stack" if gridstack} #{"active" if active}' id='#{id}' role='tabpanel'  #{"data-plugin='gridstack'" if gridstack}>".html_safe
    content << capture(&block)
    content << "</div>".html_safe
    content.html_safe
    concat(content)
  end
  def grid_stack_wrapper(&block)
    content = "<div class='grid-stack' data-plugin='gridstack'>".html_safe
    content << capture(&block)
    content << "</div>".html_safe
    content.html_safe
    concat(content)
  end
  def tab_item(id, title, active: false)
    content = "<li class='nav-item ' role='presentation'>".html_safe
    content << "<a class='nav-link #{"active" if active}' data-toggle='tab' href='##{id}'
        aria-controls='#{id}' role='tab'>".html_safe
    content << title
    content << "</a>".html_safe
    content << "</li>".html_safe
    content
  end


end
