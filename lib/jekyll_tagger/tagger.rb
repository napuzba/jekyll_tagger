module Jekyll_Tagger
  class Tagger < Jekyll::Generator
    def generate(site)
      init(site)
      generate_tags(@tags)
      generate_tags(@indexes)
    end

    def generate_tags(tagposts)
      @config.types.each{ |type|
        tagposts.each{ |tag,posts|
          if    type == 'feed'
            add_feed(tag,posts)
          elsif type == 'page'
            add_page(tag,posts)
          end
        }
      }
    end
    #---
    class << self; attr_accessor :main end
    attr_accessor :tags, :indexes
    #---

    def add_feed(tag,posts)
      layout = find_layout('feed',tag)
      return unless layout
      tag_name   = self.tag_name(tag)
      tag_slug   = self.tag_slug(tag)
      tag_file   = self.tag_file(tag,'feed')
      tag_folder = self.tag_folder(tag,'feed')
      tag_data   = {
        'layout'   => layout,
        'posts'    => posts,
        'tag'      => tag,
        'tag_slug' => tag_slug,
        'tag_name' => tag_name
      }
      @site.pages << TagPage.new( @site, @site.source, tag_folder, tag_file , tag_data )
    end

    def add_page(tag,posts)
      layout = find_layout('page',tag)
      return unless layout
      tag_name   = self.tag_name(tag)
      tag_slug   = self.tag_slug(tag)
      tag_file   = self.tag_file(tag,'page')
      tag_folder = self.tag_folder(tag,'page')
      tag_data   = {
        'layout'   => layout,
        'posts'    => posts,
        'tag'      => tag,
        'tag_slug' => tag_slug,
        'tag_name' => tag_name,
      }
      @site.pages << TagPage.new( @site, @site.source, tag_folder, tag_file , tag_data )
    end

    def tag_name(tag)
      @config.names[tag] || index_name(tag) || tag
    end

    def tag_slug(tag)
      @config.slugs[tag] || tag
    end

    def tag_folder(tag,type)
      folder = @config.folders[tag]
      if folder
        return folder
      end
      tag_folder = @config.folders[type] || @config.folders['*' ] || 'tags'
      if @config.pretty
        tag_slug   = self.tag_slug(tag)
        if tag_slug != '@'
          tag_folder = File.join(tag_folder, tag_slug)
        end
      end
      return tag_folder
    end

    def tag_file(tag,type)
      tag_slug = self.tag_slug(tag)
      if type == 'feed'
        return @config.pretty || tag == '@' ? 'feed.xml'   : "#{tag_slug}.xml"
      end
      if type == 'page'
        return @config.pretty || tag == '@' ? 'index.html' : "#{tag_slug}.html"
      end
    end

    def init(site)
      Tagger.main  = self
      @site   = site
      @config = Config.new( @site.config['tagger'] || {} )
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
      tags
    end
    def find_indexes()
      indexes = {}
      @config.indexes.each do |index|
        if index == '@'
          indexes['@'] = filter_posts( @site.posts.docs.dup , @config.include , @config.exclude )
        end
      end
      indexes
    end

    def filter_posts(posts,include,exclude)
      if not include.empty?
        posts.delete_if { |post| (post.data['tags'] & include).empty? }
      end
      if not exclude.empty?
        posts.keep_if   { |post| (post.data['tags'] & exclude).empty? }
      end
      posts
    end

    def find_layout(type,tag)
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

    def index_name(tag)
      return nil if tag[0] != '@'
      return "Recent Posts"
    end

    def is_index(tag)
      return tag[0] != '@'
    end
  end
end
