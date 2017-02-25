class Tag
  def self.count
    tags = ActsAsTaggableOn::Tag.all
    count = 0
    tags.each do |tag|
      unless tag.taggings_count == 0
        count += 1
      end
    end
    return count
  end
end
