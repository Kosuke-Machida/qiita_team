class Tag
  def self.count
    tags = ActsAsTaggableOn::Tag.all
    count = 0
    tags.each do |tag|
      count += 1 unless tag.taggings_count.zero?
    end
    count
  end
end
