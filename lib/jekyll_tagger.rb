require 'jekyll_tagger/version.rb'
require 'jekyll_tagger/config.rb'
require 'jekyll_tagger/tagger.rb'
require 'jekyll_tagger/filters.rb'

Liquid::Template.register_filter(Jekyll_Tagger::Filters)
