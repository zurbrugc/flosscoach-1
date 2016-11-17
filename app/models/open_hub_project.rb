require 'active_resource'

class MyXMLFormatter
  include ActiveResource::Formats::XmlFormat

  def decode(xml)
    ActiveResource::Formats::XmlFormat.decode(xml)['result']['project']
  end
end

class OpenHubProject < ActiveResource::Base

  # Get Open Hub url from yml file
  yml = YAML.load_file('app/models/open_hub_project.yml')
  # Set the Open Hub site url
  self.site = yml['open_hub_url']

  self.format =  MyXMLFormatter.new
  self.element_name = "projects"

  @headers = { 'api_key' => "#{Rails.application.secrets.OPENHUB_KEY}" }

  def self.find_by_id(id)
    self.find(id, :params => {'api_key' => "#{Rails.application.secrets.OPENHUB_KEY}" })
  end

  def self.find_by_name(nome)
    self.find(:all, :params => {'query' => nome ,'api_key' => "#{Rails.application.secrets.OPENHUB_KEY}" })
  end

end
