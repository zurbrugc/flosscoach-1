class Tag < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
  has_and_belongs_to_many :projects, -> { distinct }


  def self.array_to_tags(array)
    tags = array.uniq.collect{ |string| Tag.find_or_create_by(name: string) }
    tags
  end

  def self.tags_to_array(tags)
    tags = tags.collect {|tag| tag.name}
    tags.uniq
  end

  def to_s
    name
  end

end
