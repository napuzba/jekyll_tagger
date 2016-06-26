module Jekyll_Tagger
  class Tagger < Jekyll::Generator
    def generate(site)
      init(site)
    end

    #---
    class << self; attr_accessor :main end
    attr_accessor :tags
    #---

    def tag_name(tag)
      @config.names[tag] || tag
    end

    def tag_slug(tag)
      @config.slugs[tag] || tag
    end


    def init(site)
      Tagger.main  = self
      @site   = site
      @config = Config.new( @site.config['tagger'] || {} )
      @tags = find_tags()
    end

    def find_tags()
      tags = @site.tags
      if not @config.include.empty?
        tags.reject! { |tag| not @config.include.include? tag  }
      end
      if not @config.exclude.empty?
        tags.reject! { |tag|     @config.exclude.include? tag  }
      end
      tags
    end
  end
end
