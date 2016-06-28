require 'jekyll_tagger/version'
require 'jekyll_tagger/config'
require 'jekyll_tagger/page_info'
require 'jekyll_tagger/pager'
require 'jekyll_tagger/tag_page'
require 'jekyll_tagger/tagger'
require 'jekyll_tagger/filters'

Liquid::Template.register_filter(Jekyll_Tagger::Filters)
