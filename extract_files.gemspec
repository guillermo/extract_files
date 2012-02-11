# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "extract_files"

Gem::Specification.new do |s|
  s.name        = "extract_files"
  s.version     = ExtractFiles::VERSION
  s.authors     = ["Guillermo Álvarez"]
  s.email       = ["guillermo@cientifico.net"]
  s.homepage    = "https://github.com/guillermo/extract_files"
  s.summary     = %q{Extract files from stdin or files given an extension/extensions}
  s.description = %q{Tired of generating big builds for the cdn? Just want to know wich files your designers in their css are really using? The images of all the static fiels? extract_files look inside json, html, css, and look for files based on a given extension or extensions.
		run extract_files -h to have more help.}

  s.rubyforge_project = "extract_files"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "minitest"
end
