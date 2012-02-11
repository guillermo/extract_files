# Extract Files [![Build Status](https://secure.travis-ci.org/guillermo/extract_files.png)](http://travis-ci.org/guillermo/extract_files)

Extract files from files or stdin for a given extension.

## Yes, but i can do that with sed.

I know. Before this I use this snippet:

    for css_file in `find css -name "*.css" ` ; do sed  -n 's/^.*url *( *"*\'"'"'*\([^"]*\)\'"'"'*"* *).*$/'`dirname $css_file`'\/\1/p' $css_file  ; done | ruby  -n -e "puts File.expand_path(\$_)[File.expand_path('.').size+1..-1]"

Probably could be improve.


## Usage

Given a css file with absolute and relative images

		$ cat style.css
		body {
			background: url(../images/bg.jpg), url ( ../images/bg2.jpg );
			background: url("../images/bg3.jpg");
			background: url('/images/bg4.jpg);
			background: url('images/bg5.jpg');
		}

Extract the images only ``-e jpg -e png -e gif``

		$ cat style.css | extract_files -e jpg
		../images/bg.jpg
		../images/bg2.jpg
		../images/bg3.jpg
		/images/bg4.jpg
		images/bg5.jpg

Now, relative to the css directory ``-b css``

		$ cat style.css | extract_files  -e jpg -b css
		css/../images/bg.jpg
		css/../images/bg2.jpg
		css/../images/bg3.jpg
		css/images/bg4.jpg
		css/images/bg5.jpg

And do the path expansion ``-p``.

		$ cat style.css | extract_files  -e jpg -b css -p
		images/bg.jpg
		images/bg2.jpg
		images/bg3.jpg
		css/images/bg4.jpg
		css/images/bg5.jpg

Or show the full path ``-f``.

		$ cat style.css | extract_files  -e jpg -b css -p -f
		/Users/guillermo/Documents/extract_files/images/bg.jpg
		/Users/guillermo/Documents/extract_files/images/bg2.jpg
		/Users/guillermo/Documents/extract_files/images/bg3.jpg
		/Users/guillermo/Documents/extract_files/css/images/bg4.jpg
		/Users/guillermo/Documents/extract_files/css/images/bg5.jpg



You can pass the file/files directly: 

		$ extract_files * -e png
		image1.png
		/images/img1.png


## Install

There are two ways of installing this small libbrary:

### Rubygems

    $ gem install extract_files

You will have the code as a library and the binary

### Script only

		curl -O https://raw.github.com/guillermo/extract_files/master/bin/extract_files
		chmod +x extract_files

## Development

The script is generated automatically with rake, so if you fork, ensure that you edit the correct files.

## License

<pre>
 ____               __        __             
| __ )  ___  ___ _ _\ \      / /_ _ _ __ ___ 
|  _ \ / _ \/ _ \ '__\ \ /\ / / _` | '__/ _ \
| |_) |  __/  __/ |   \ V  V / (_| | | |  __/
|____/ \___|\___|_|    \_/\_/ \__,_|_|  \___|
                                             
 _     _                         
| |   (_) ___ ___ _ __  ___  ___ 
| |   | |/ __/ _ \ '_ \/ __|/ _ \
| |___| | (_|  __/ | | \__ \  __/
|_____|_|\___\___|_| |_|___/\___|
                                 
----------------------------------------------------------------------------
"THE BEER-WARE LICENSE" (Revision 42):
guillermo@cientifico.net wrote this file. As long as you retain this 
notice you can do whatever you want with this stuff. If we meet some day,
and you think this stuff is worth it, you can buy me a beer in return 
Guillermo Alvarez Fernandez
----------------------------------------------------------------------------

</pre>

