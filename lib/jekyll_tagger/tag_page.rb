module Jekyll_Tagger
  class TagPage < Jekyll::Page
    def initialize(site, base, dir, name, data = {})
      self.content = data.delete('content') || ''
      self.data    = data
      super(site, base, dir, name)
    end

    def read_yaml(*)
      # Do nothing
    end


    def active_tag_data(site = Tagger.site)
      return site.config['tag_data'] unless site.config["ignored_tags"]
      site.config["tag_data"].reject { |tag, set| site.config["ignored_tags"].include? tag }
    end
  end
end