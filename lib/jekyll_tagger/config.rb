module Jekyll_Tagger
  class Config
    attr_accessor :include , :exclude , :indexes , :names , :slugs , :types, :style , :layouts , :folders , :page_size , :page_show , :pretty

    def initialize(config)
      @config    = config
      @include   = value( 'include'   , [] )
      @exclude   = value( 'exclude'   , [] )
      @indexes   = value( 'indexes'   , [] )
      @names     = value( 'names'     , {} )
      @slugs     = value( 'slugs'     , {} )
      @types     = value( 'types'     , ['page' , 'feed'] )
      @style     = value( 'style'     , 'pretty' )
      @layouts   = value( 'layouts'   , {} )
      @folders   = value( 'folders'   , {} )
      @page_size = value( 'page_size' , 0  )
      @page_show = value( 'page_show' , 5  )
      @pretty    = @style == 'pretty'
    end

    def value(key,default)
      @config[key] || default
    end
  end
end
