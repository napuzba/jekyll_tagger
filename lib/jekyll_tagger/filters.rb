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

    def tag_url(tag,type,number=1)
      Tagger::main.tag_url(tag,type,number)
    end

    def tag_link_page(tag , html_opts = '')
      name = tag_name(tag)
      url  = tag_url(tag,'page')
      %Q{<a href="#{url}" #{html_opts}>#{name}</a>}
    end

    def pad(ss,size)
      ss.to_s.ljust(size)
    end
  end
end
