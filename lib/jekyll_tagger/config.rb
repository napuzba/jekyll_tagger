module Jekyll_Tagger
  class Config
    attr_accessor :include, :exclude , :names  , :slugs

    def initialize(config)
      @config  = config

      @include = value( 'include' , [] )
      @exclude = value( 'exclude' , [] )
      @names   = value( 'names'   , {} )
      @slugs   = value( 'slugs'   , {} )
    end

    def value(key,default)
      @config[key] || default
    end
  end
end
