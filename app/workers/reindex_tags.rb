class ReindexTags
  @queue = :reindex_tags

  def self.display_name
    "Reindexing tags"
  end

  def self.perform
    ActsAsTaggableOn::Tag.reindex(:batch_size => 500, :include => :taggings, :batch_commit => false)
  end

end
