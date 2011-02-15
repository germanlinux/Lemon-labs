require "rubygems"
require 'fusefs'

class HelloDir
  def contents(path)
      puts "contents: => #{path}"  
    ['hello.txt']
  end
  
  def file?(path)
      puts "file: => #{path}"
      path == '/hello.txt'
  end
  
  def read_file(path)
      puts "read_file: => #{path}"
    "Hello, World!\n"
  end

  def size(path)
      puts "size: => #{path}"
    read_file(path).size
  end
end

hellodir = HelloDir.new
FuseFS.set_root( hellodir )

# Mount under a directory given on the command line.
FuseFS.mount_under ARGV.shift
FuseFS.run
