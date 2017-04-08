class Tag
  def self.all
    Project.pluck(:tags).flatten
  end

  def self.all_with_count
    Project.pluck(:tags).flatten
    Hash.new(0).tap { |h| arr.each { |v| h[v] += 1 } }.sort_by {|k, v| v}.to_h
  end

  def self.all_ordered_by_count
    arr = Project.pluck(:tags).flatten
    Hash.new(0).tap { |h| arr.each { |v| h[v] += 1 } }.sort{|k, v| v[1] <=> k[1]}.to_h
  end

  def self.exists?(tag)
    Project.pluck(:tags).include?(tag)
  end
end
