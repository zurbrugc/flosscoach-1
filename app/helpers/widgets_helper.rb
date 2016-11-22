module WidgetsHelper
      def make_all_widgets(ohp = nil)
      widgets = []
      if(ohp)
        widgets << make_widget_about("#{ohp.description} <br>
                         <iframe src='https://www.openhub.net/p/#{ohp.vanity_url}/widgets/project_factoids_stats' scrolling='no' marginheight='0' marginwidth='0' 
                         style='height: 220px; width: 370px; border: none'></iframe>")
        widgets << make_widget_links("OpenHub URL: <a href='#{ohp.html_url}'>#{ohp.html_url}</a><br>
                          Homepage Url: <a href='#{ohp.homepage_url}'>#{ohp.homepage_url}</a><br>
                          Download URL: <a href='#{ohp.download_url}'>#{ohp.download_url}</a>")
      else
        widgets << make_widget_links
        widgets << make_widget_about
      end
      widgets << make_widget_technical_skills
      widgets << make_widget_soft_skills
      widgets << make_widget_basic_contribution_flow
      widgets << make_widget_workspace_setup
      widgets << make_widget_resources_provided
      widgets << make_widget_code_documentation
      widgets << make_widget_searchable_resources
      widgets << make_widget_send_contribution

      widgets
    end
    #Auto builds for widgets
    def make_widget_about(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "About"
      widget.slug = "about"
      widget.tab = "about"
      widget.pos_x = 4
      widget.pos_y = 0
      widget.width = 8
      widget.height = 5
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end

    def make_widget_links(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Links"
      widget.slug = "links"
      widget.tab = "about"
      widget.pos_x = 0
      widget.pos_y = 0
      widget.width = 4
      widget.height = 3
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end

    def make_widget_technical_skills(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Technical Skills"
      widget.slug = "technical_skills"
      widget.tab = "how_to_start"
      widget.pos_x = 0
      widget.pos_y = 0
      widget.width = 6
      widget.height = 4
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end

    def make_widget_soft_skills(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Soft skills required"
      widget.slug = "soft_skills"
      widget.tab = "how_to_start"
      widget.pos_x = 6
      widget.pos_y = 0
      widget.width = 6
      widget.height = 4
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end

    def make_widget_basic_contribution_flow(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Basic contribution flow to follow"
      widget.slug = "basic_contribution_flow"
      widget.tab = "how_to_start"
      widget.pos_x = 0
      widget.pos_y = 4
      widget.width = 12
      widget.height = 7
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = '<div class="steps steps-vertical">
                    <div class="step done">
                      <span class="step-number">1</span>
                      <div class="step-desc">
                        <span class="step-title">Learn about the project and skills</span>
                        <p>First you need to learn about the project. Search on it and see if it really interests you propose.</p>
                      </div>
                    </div>
                    <div class="step done">
                      <span class="step-number">2</span>
                      <div class="step-desc">
                        <span class="step-title">Setup you local workspace</span>
                        <p>Install the development environment on your machine.</p>
                      </div>
                    </div>

                    <div class="step done">
                      <span class="step-number">3</span>
                      <div class="step-desc">
                        <span class="step-title">Find a task to start with</span>
                        <p>Search a task for beginners to start contributing</p>
                      </div>
                    </div>

                    <div class="step done">
                      <span class="step-number">4</span>
                      <div class="step-desc">
                        <span class="step-title">Study and change the code</span>
                        <p>Dont forget to test your code!</p>
                      </div>
                    </div>
                    <div class="step done">
                      <span class="step-number">5</span>
                      <div class="step-desc">
                        <span class="step-title">Submit your contribution</span>
                        <p>Congratulations, you have successfully contributed to the project.</p>
                      </div>
                    </div>
                    <div class="step error">
                      <div class="step-desc text-center">
                        <span class="step-title text-center">Have a question?</span>
                        <p>Get support from the community.</p>
                      </div>
                    </div>
                  </div>'
      widget
    end

    def make_widget_workspace_setup(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Workspace setup"
      widget.slug = "workspace_setup"
      widget.tab = "configure_workspace"
      widget.pos_x = 0
      widget.pos_y = 0
      widget.width = 5
      widget.height = 4
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end


    def make_widget_resources_provided(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Resources provided by project"
      widget.slug = "resources_provided"
      widget.tab = "configure_workspace"
      widget.pos_x = 5
      widget.pos_y = 0
      widget.width = 7
      widget.height = 5
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end


    def make_widget_code_documentation(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Code documentation"
      widget.slug = "code_documentation"
      widget.tab = "know_the_code"
      widget.pos_x = 0
      widget.pos_y = 0
      widget.width = 5
      widget.height = 4
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end

    def make_widget_searchable_resources(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Searcheable resources"
      widget.slug = "searcheable_resources"
      widget.tab = "know_the_code"
      widget.pos_x = 5
      widget.pos_y = 0
      widget.width = 5
      widget.height = 4
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end

    def make_widget_send_contribution(pre_content = "Fill with text")
      widget = Widget.new
      widget.title = "Submitting yout contribution"
      widget.slug = "send_contribution"
      widget.tab = "know_the_code "
      widget.pos_x = 5
      widget.pos_y = 0
      widget.width = 5
      widget.height = 4
      widget.closeable = false
      widget.resizeable = true
      widget.retractable = true
      widget.content = pre_content
      widget
    end
end