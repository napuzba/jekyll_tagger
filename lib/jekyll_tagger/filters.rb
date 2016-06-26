module Jekyll_Tagger
  module Filters
    def tag_list( separator = ' | ')
      Tagger::main.tags.map {|tag_posts|
        "#{tag_posts[0]} (#{tag_posts[1].count})"
      }.join(separator)
    end

    def tag_name(tag)
      Tagger::main.tag_name(tag)
    end

    def tag_slug(tag)
      Tagger::main.tag_slug(tag)
    end
  end
end
