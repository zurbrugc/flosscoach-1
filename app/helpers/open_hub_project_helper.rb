module OpenHubProjectHelper
  def iframe_html
     "<iframe src='https://www.openhub.net/p/#{vanity_url}/widgets/project_factoids_stats' scrolling='no' marginheight='0' marginwidth='0' style='height: 220px; width: 370px; border: none'></iframe>"
  end

  def links_html
    "OpenHub URL: <a href='#{openhub_url}'>#{openhub_url}</a><br>
    Homepage Url: <a href='#{homepage_url}'>#{homepage_url}</a><br>
    Download URL: <a href='#{download_url}'>#{download_url}</a>"
  end

  def iframe_languages_html
    "<iframe src='https://www.openhub.net/p/#{vanity_url}/widgets/project_languages' , scrolling='no' marginheight='0' marginwidth='0' style='height: 210px; width: 350px; border: none'></iframe>"
  end
end
