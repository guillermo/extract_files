
require 'optparse'


options = {:extensions => []}
OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename $0} [options] file"


  opts.on("-e", "--ext EXT", "Extract files with extension EXT. Can be used several times.") do |v|
    options[:extensions] << v
  end

	opts.separator ""

  opts.on("-b", "--base-directory DIR", "Use DIR as a base directory") do |base_dir|
    options[:base] = base_dir
  end

  opts.on("-p", "--expand-path", "Remove .. from output directories") do |e|
    options[:expand] = true
  end

	opts.on("-f", "--full-path", "Show full path") do
		options[:full_path] = true
	end

	opts.separator ""

	opts.on("-v", "--version", "Show the version") do
		puts ExtractFiles::VERSION
		exit 0
	end

  opts.on_tail("-h", "--help", "Show this help") do
    puts opts
    exit 0
  end

end.parse!

if ARGV.empty? && !$stdin.tty?
	ExtractFiles.extract!($stdin, options)
	exit 0
end

ARGV.each do |file|
  (raise "File #{file} not found" ; exit -1) unless File.exists?(file)

  if options[:extensions].any?

		begin
			file = File.open(file)
			ExtractFiles.extract!(file, options)
		ensure
			file.close
		end
  end


end
