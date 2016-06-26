module Jekyll_Tagger
  module Filters
    def tags_list( separator = ' | ')
      Tagger::main.tags.map {|tag_posts|
        "#{tag_posts[0]} (#{tag_posts[1].count})"
      }.join(separator)
    end
  end
end
