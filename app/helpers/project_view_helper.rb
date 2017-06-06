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
  #TODO: Receive @project by argument in function
  def request_ownership_button(project)
     unless project.owners.include?(current_user)
       if project.pendent_owners.include?(current_user)
         ownership_request = project.ownership_requests.find_by_user_id(current_user.id)
         button_to "Dismiss ownership request",  [project, ownership_request], method: :delete,
         class: "btn btn-info waves-effect waves-classic", remote: true
       else
        button_to "Send ownership request", [project, :ownership_requests],
        class: "btn btn-info waves-effect waves-classic", remote: true
      end
    end
  end

  def approve_ownership_request_button(ownership_request)
    project = ownership_request.project
    button_to "Approve", [project,ownership_request], params: {approved: true}, method: :put,
    class: "btn btn-success waves-effect waves-classic", remote: true
  end

  def refuse_ownership_request_button(ownership_request)
    project = ownership_request.project
    button_to "Refuse",  [project,ownership_request],params: {approved: false}, method: :put,
    class: "btn btn-danger waves-effect waves-classic", remote: true
  end

end
