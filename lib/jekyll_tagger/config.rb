module Jekyll_Tagger
  class Config
    # Array of tags to include in active tags
    attr_reader :include
    # Array of tags to exclude in active tags
    attr_reader :exclude
    # Hash from tags to names
    attr_reader :names
    # Hash from tags to slugs
    attr_reader :slugs
    # Array of indexes
    attr_reader :indexes
    # Array of items to generate. values: 'page' , 'feed'
    attr_reader :types
    # The style to generate. values: 'simple', 'pertty'
    attr_reader :style
    # Hash from tags to layouts
    attr_reader :layouts
    # Hash from tags to folders
    attr_reader :folders
    # The number of posts per page.
    attr_reader :page_size
    # The number of PageInfo per page.
    attr_reader :page_show
    # Whether the #style is 'pertty'
    attr_reader :pretty
    # The order of the posts.
    attr_reader :post_order

    ##
    # Create a new +Config+ by parsing +config+ hash
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
      @post_order= value( 'post_order', "descending"  )
      @pretty    = @style == 'pretty'
    end

    private
    ##
    # Find value of +key+ if exists, otherwise return +default+
    def value(key,default)
      @config[key] || default
    end
  end
end
