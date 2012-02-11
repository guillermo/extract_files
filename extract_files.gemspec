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
  s.description = File.read('README.md')

  s.rubyforge_project = "extract_files"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "minitest"
end
