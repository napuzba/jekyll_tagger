module Jekyll_Tagger
  class Config
    attr_accessor :include, :exclude
    def initialize(config)
      @config  = config

      @include = value( 'include' , [] )
      @exclude = value( 'exclude' , [] )
    end

    def value(key,default)
      @config[key] || default
    end
  end
end
