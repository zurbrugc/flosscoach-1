require 'active_resource'

class MyXMLFormatter
  include ActiveResource::Formats::XmlFormat

  def decode(xml)
    ActiveResource::Formats::XmlFormat.decode(xml)['result']['project']
  end
end

class OpenHubProject < ActiveResource::Base

  self.site = "https://www.openhub.net/"
  self.format =  MyXMLFormatter.new
  self.element_name = "projects"

  @headers = { 'api_key' => "#{Rails.application.secrets.OPENHUB_KEY}" }

  def self.find_by_id(id)
    self.find(id, :params => {'api_key' => "a8b2141ce1264ca5e99e49e1cb37dbb589949bc910cc6d71a938c8db7f51136c" })
  end

  def self.find_by_name(nome)
    self.find(:all, :params => {'query' => nome ,'api_key' => "a8b2141ce1264ca5e99e49e1cb37dbb589949bc910cc6d71a938c8db7f51136c" })
  end

end