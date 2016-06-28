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
  end
end