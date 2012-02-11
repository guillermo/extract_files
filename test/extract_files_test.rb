
require 'minitest/autorun'
require 'extract_files'


class ExtractFilesTest < MiniTest::Unit::TestCase

  HTML = ["css/font.css", "css/font2.css", "../css/font3.css", "./css/font3.css", "js/script.js", "js/script2.JS", "/js/script3.JS", "./js/script4.JS", "/images/img1.png", "./images/img2.GIF", "../images/img3.GIF"]
  JSON = ["image1.png", "image_3.jpeg", "images/img2.gif"]
  CSS =  ["../images/bg.jpg", "../images/bg2.jpg", "../images/bg3.jpg", "/images/bg4.jpg", "images/bg5.jpg"]


  def test_extract
    assert_equal JSON, extract!('files.json'), 'should extract files from files.json'
    assert_equal HTML, extract!('index.html'), 'should extract files from index.html'
    assert_equal CSS, extract!('style.css'), 'should extract files from style.css'
  end

  CSS2 = ["fixtures/../images/bg.jpg", "fixtures/../images/bg2.jpg", "fixtures/../images/bg3.jpg", "fixtures/images/bg4.jpg", "fixtures/images/bg5.jpg"]

  def test_base
    assert_equal CSS2, extract!('style.css', :base => "fixtures"), 'should append fixtures path'
  end

  CSS3 = ["images/bg.jpg", "images/bg2.jpg", "images/bg3.jpg", "fixtures/images/bg4.jpg", "fixtures/images/bg5.jpg"]

  def test_base_expand
    assert_equal CSS3, extract!('style.css', :base => 'fixtures', :expand => true), "Should expand the path"
  end

  CSS4 = ["/images/bg.jpg", "/images/bg2.jpg", "/images/bg3.jpg", "/fixtures/images/bg4.jpg", "/fixtures/images/bg5.jpg"]
  def test_base_expand_full
    files = extract!('style.css', :base => 'fixtures', :expand => true, :full_path => true).map{|f| f[File.expand_path('.').size..-1]}
    assert_equal CSS4, files, "Should show the full path"
  end

  def extract!(filename, options = {})
    file = File.join(File.dirname($0), 'fixtures', filename)
    raise "File #{file} not found" unless File.file?(file)

    f = File.open(file,"r")
    ExtractFiles.get!(f,options)
  ensure
    f.close
  end

end
