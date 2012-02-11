
module ExtractFiles
  VERSION = "0.0.2"

  extend self

  DEFAULT_EXTENSIONS = %w(png jpeg jpg gif css js)

  # Process the input io, or anything that respond to __read__ and return a string.
  # options are:
  #
  #   * **extensions**: Array of extensions to look for. Default is DEFAULT_EXTENSIONS
  #
  #   * **base**: Base directory. Image a relative path for a image **bg.png** in a css file inside the **styles** folder. The default output
  #       will say "../images/bg.png". If you say that the base directory is "styles" the output will be "styles/../images/bg.png". Is unset by default.
  #
  #   * **expand**: If the output is somehing like "sytles/../images/bg.png" expand will convert that in "images/bg.png". Is enabled by false.
  #
  #   * **full_path**: Show the full_path
  #
  # If no **block** is passed, it will output to the stdout throught puts. If a block is given, it will yield each founded entry.
  #
  def extract!(io, options = {})
    raise "Incorrect format for IO" unless io.respond_to?(:read)

    options = {:extensions => DEFAULT_EXTENSIONS}.merge(options)

    ext = "(" + options[:extensions].join("|") + ")"
    re = /([a-z0-9\-_\/\.]*[a-z0-9]*\.#{ext})/i

    io.read.scan(re).each do |match|
      path = match[0]
      path = File.join(options[:base], path) if options[:base]
      path = simplify_path(path)             if options[:expand]
      path = File.expand_path(path)          if options[:full_path]
      if block_given?
        yield path
      else
        puts path
      end
    end

  end

  # get! is a wrapper for extract! that returns and array of the matches.
  def get!(io,options)
    matches = []
    extract!(io,options){|match| matches<<match}
    matches
  end

  protected

  def simplify_path(string)
    string.gsub(/[^\/]*\/\.\.\//,'').gsub(/^\.\//,'').gsub(/\.\//,'')
  end


end
