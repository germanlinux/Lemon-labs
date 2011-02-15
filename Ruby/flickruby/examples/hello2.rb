require 'rubygems'
require 'fusefs'

class HelloDir
def contents(path)
puts "contents :path=#{path}"
['sets', '2', '3', '4']
end

def file?(path)
puts "file? :path=#{path}"
not path =~ /ts$|2$/
end

def directory?(path)
puts "directory? :path=#{path}"
path =~ /ts$|2$/
end

def read_file(path)
"hello?"
end
end

hellodir = HelloDir.new
FuseFS.set_root( hellodir )

# Mount under a directory given on the command line.
FuseFS.mount_under ARGV.shift
FuseFS.run
________________________________________
