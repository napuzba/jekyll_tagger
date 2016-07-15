module Jekyll_Tagger
  class Tagger < Jekyll::Generator
    def generate(site)
      init(site)
      generate_tags(@tags   )
      generate_tags(@indexes)
    end

    def generate_tags(tag_posts)
      @config.types.each do |type|
        tag_posts.each   do |tag,posts|
          if type == 'feed' then (add_feed  tag,posts) end
          if type == 'page' then (add_pages tag,posts) end
        end
      end
    end
    #---
    class << self; attr_accessor :main end
    attr_accessor :tags, :indexes
    #---

    def add_feed(tag,posts)
      layout = find_layout(tag,'feed')
      return unless layout
      tag_name   = (self.tag_name   tag       )
      tag_slug   = (self.tag_slug   tag       )
      tag_file   = (self.tag_file   tag,'feed')
      tag_folder = (self.tag_folder tag,'feed')
      tag_data   = {
        'layout'   => layout,
        'posts'    => posts,
        'tag'      => tag,
        'tag_slug' => tag_slug,
        'tag_name' => tag_name
      }
      @site.pages << TagPage.new( @site, @site.source, tag_folder, tag_file , tag_data )
    end

    def add_page(tag,pager,number)
      layout = find_layout(tag,'page')
      return if !layout
      tag_name   = (self.tag_name   tag              )
      tag_slug   = (self.tag_slug   tag              )
      tag_folder = (self.tag_folder tag,'page',number)
      tag_file   = (self.tag_file   tag,'page',number)
      data = {
        'layout'    => layout,
        'posts'     => pager.page_items(number),
        'tag'       => tag,
        'tag_slug'  => tag_slug,
        'tag_name'  => tag_name,
        'title'     => (number > 1 ? sprintf('%s - page %d', tag_name , number) : tag_name) ,
        'page_list' => (pager.page_list  number, @config.page_show , number),
        'page_next' => (pager.page_next  number),
        'page_prev' => (pager.page_prev  number),
        'page_first'=> (pager.page_first number),
        'page_last' => (pager.page_last  number),
        'page_curr' => number
      }
      @site.pages << TagPage.new( @site, @site.source, tag_folder, tag_file , data )
    end

    def add_pages(tag,posts)
      pager = Pager.new( posts , @config.page_size , lambda { |number| return self.tag_url(tag,'page',number) })
      for kk in 1..(pager.page_count)
        add_page(tag,pager,kk)
      end
    end

    def tag_name(tag)
      @config.names[tag] || index_name(tag) || tag
    end

    def tag_slug(tag)
      @config.slugs[tag] || tag
    end

    def tag_folder(tag,type,number=1)
      tag_folder = @config.folders[tag]
      if not tag_folder
        tag_folder = @config.folders[type] || @config.folders['*' ] || 'tag'
        if @config.pretty
          tag_slug   = self.tag_slug(tag)
          if tag_slug != '@'
            tag_folder = File.join(tag_folder, tag_slug)
          end
        end
      end
      if number > 1 && @config.pretty
        tag_folder = File.join(tag_folder, 'page',number.to_s)
      end
      return tag_folder
    end

    def tag_file(tag,type,number=1)
      tag_slug = self.tag_slug(tag)
      if type == 'feed'
        return @config.pretty || tag == "@" ? 'feed.xml'   : "#{tag_slug}.xml"
      end
      if type == 'page'
        slug = tag_slug
        if tag == "@"
          slug = 'index'
        end
        if number == 1
          name = @config.pretty ? 'index' : slug
        else
          name = @config.pretty ? 'index' : "#{slug}-#{number}"
        end
        return "#{name}.html"
      end
    end

    def tag_url(tag,type, number = 1)
      tag_folder = (self.tag_folder tag,type,number)
      tag_file   = (self.tag_file   tag,type,number)
      url_base = File.join('/', @site.config['baseurl'].to_s, tag_folder)
      if tag_file == 'index.html'
        if url_base[-1] != '/'
          url_base += '/'
        end
        return url_base
      end
      return File.join(url_base, tag_file )
    end

    def index_name(tag)
      return nil if tag[0] != '@'
      return "Recent Posts"
    end

    def init(site)
      Tagger.main  = self
      @site    = site
      @config  = Config.new( @site.config['tagger'] || {} )
      @tags    = find_tags()
      @indexes = find_indexes()
    end

    def find_tags()
      tags = @site.tags
      if not @config.include.empty?
        tags.reject! { |tag| not @config.include.include? tag  }
      end
      if not @config.exclude.empty?
        tags.reject! { |tag|     @config.exclude.include? tag  }
      end
      tags.each { |tag,posts|    validate_posts(posts) }
      return tags
    end

    def find_indexes()
      indexes = {}
      @config.indexes.each do |index|
        if index == '@'
          indexes['@'] = find_posts( @site.posts.docs.dup , @config.include , @config.exclude )
        end
      end
      return indexes
    end

    def find_posts(posts,include,exclude)
      if not include.empty?
        posts.delete_if { |post| (post.data['tags'] & include).empty? }
      end
      if not exclude.empty?
        posts.keep_if   { |post| (post.data['tags'] & exclude).empty? }
      end
      validate_posts(posts)
      return posts
    end

    def validate_posts(posts)
      posts.reject! { |post| post.data['tag_opts'] && post.data['tag_opts'].include?('hide') }
      if @config.post_order == 'descending'
        posts.sort!.reverse!
      end
    end
    def find_layout(tag,type)
      layout = @config.layouts["#{type}_#{tag}"] ; return layout if layout_valid?(layout,true)
      layout = @config.layouts["#{type}"]        ; return layout if layout_valid?(layout,true)
      layout = @config.layouts['*']              ; return layout if layout_valid?(layout,true)
      layout = "tag_#{type}_#{tag}"              ; return layout if layout_valid?(layout)
      layout = "tag_#{type}"                     ; return layout if layout_valid?(layout,true)
      return false
    end

    def layout_valid?(layout,warn = false)
      if layout == nil
        return false
      end
      body = @site.layouts[layout]
      if body
        return body
      end
      if warn
        Jekyll.logger.warn("Build Warning:", "Layout <#{layout}> is invalid")
      end
      return false
    end
  end
end
