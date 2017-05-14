require 'active_resource'
class MyXMLFormatter
  include ActiveResource::Formats::XmlFormat
  def decode(xml)
    ActiveResource::Formats::XmlFormat.decode(xml)['result']['project']
  end
end

class OpenHubProject < ActiveResource::Base
  include OpenHubProjectHelper
  attr_accessor :id, :name, :openhub_url, :description,
  :homepage_url, :logo_url, :tags, :vanity_url, :download_url

  self.site = "https://www.openhub.net/"
  self.format =  MyXMLFormatter.new
  self.element_name = "projects"
  @headers = { 'api_key' => "#{Rails.application.secrets.OPEN_HUB_KEY}" }

  def self.find_by_id(id)
    params = {'api_key' => "#{Rails.application.secrets.OPEN_HUB_KEY}" }
    data = OpenHubProject.find(id, :params => params)
    project = OpenHubProject.build(data)
    project
  end

  def self.find_by_name(nome)
    params = {'query' => nome ,'api_key' => "#{Rails.application.secrets.OPEN_HUB_KEY}" }
    data = OpenHubProject.find(:all, :params => params).first
    p data
    project = OpenHubProject.build(data)
    project
  end

  def self.build(data)
    project = OpenHubProject.new
    project.id = data.attributes["id"]
    project.name = data.attributes["name"]
    project.openhub_url = data.attributes["html_url"]
    project.download_url =  data.attributes["download_url"]

    project.description = data.attributes["description"]
    project.homepage_url = data.attributes["homepage_url"]
    project.logo_url = data.attributes["medium_logo_url"] || data.attributes["small_logo_url"]
    project.tags = data.attributes["tags"].attributes["tag"]
    project.vanity_url = data.attributes["vanity_url"]
    project
  end

  def to_open_hub_data
    data = OpenHubData.new
    data.open_hub_id = id
    data.name = name
    data.description = description
    data.homepage_url = homepage_url
    data.vanity_url = vanity_url
    data.download_url = download_url
    data.logo_url = logo_url
    data
  end


end
