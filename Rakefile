require "bundler/gem_tasks"
require 'rake/clean'


task :test do
	sh "ruby -I lib -rubygems test/extract_files_test.rb"
end

file 'bin/extract_files' => ['lib/extract_files.rb', 'lib/extract_files/optparse.rb'] do
	sh "echo '#!/usr/bin/env ruby' > bin/extract_files"
	sh "cat lib/extract_files.rb >> bin/extract_files"
	sh "cat lib/extract_files/cli.rb >> bin/extract_files"
	sh "chmod +x bin/extract_files"
end

CLEAN.add 'bin/extract_files'


