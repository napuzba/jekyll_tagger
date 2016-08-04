# coding: utf-8
lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll_tagger/version'



Gem::Specification.new do |spec|
  spec.name          = "jekyll_tagger"
  spec.version       = Jekyll_Tagger::VERSION
  spec.authors       = ["napuzba"]
  spec.email         = ["kobi@napuzba.com"]
  spec.summary       = %q{Jekyll plugin for generationg tag pages and feeds.}
  spec.homepage      = "http://www.napuzba.com/story/generate-tags-with-jekyll-tagger/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").grep(%r{(lib)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "jekyll"
  spec.add_development_dependency "clash"
end
