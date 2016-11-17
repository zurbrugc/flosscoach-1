class Project < ActiveResource::Base
  self.format =  ActiveResource::Formats::XmlFormat
  yml = YAML.load_file('app/models/open_hub_project.yml')
  self.site = yml['open_hub_url']
end
