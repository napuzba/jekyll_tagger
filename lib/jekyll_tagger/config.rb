module Jekyll_Tagger
  class Config
    attr_accessor :include , :exclude , :names , :slugs ,
                  :types, :style , :pretty, :folders , :layouts , :indexes
    def initialize(config)
      @config  = config

      @include = value( 'include'       , [] )
      @exclude = value( 'exclude'       , [] )
      @indexes = value( 'indexes'       , [] )
      @names   = value( 'names'         , {} )
      @slugs   = value( 'slugs'         , {} )

      @types   = value( 'types'         , ['page' , 'feed'] )
      @style   = value( 'style'         , 'pretty' )
      @layouts = value( 'layouts'       , {} )
      @folders = value( 'folders'       , {} )
      @pretty  = @style == 'pretty'
    end

    def value(key,default)
      @config[key] || default
    end
  end
end
