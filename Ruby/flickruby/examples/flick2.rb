#!/usr/bin/ruby
require 'rubygems'
require 'inode'
require 'json'
require 'fusefs'
#require 'json'
require 'fusefs'
##  create arbo ###
class Flickruby < FuseFS::FuseDir
    attr_accessor :media, :JSONset
    def initialize
        @media=Hash.new
        @media["sets"]= {}
        @media["sets"]["leun"]=     {"p1" => "cont1"}
        @media["sets"]["leun"]=     {"p2" => "cont2"}
        @media["sets"]["ledeux"]=   {"p3" => "cont3"}
    end
    def dump 
        @media.dump
    end
    #################  fuse api 
    def contents(path)
        segments= scan_path(path)
        segment= segments.inject(@media){|value,segment| value[segment]}
        puts "content #{segment.keys.sort} for #{path}"
        segment.keys.sort
   end
  
    def file?(path)
        puts "file? for #{path}"
        false
     # @media.inode_of[path].is_kind_of? AFile
      
      #$stderr.puts "file: => #{path}"
      #$stderr.puts   @media.inode_of[path].is_kind_of? Afile
      
    end
    def directory?(path)
        
       
        segments= scan_path(path)
        puts "seg => #{segments.inspect}"
        true
        #   @media.inode_of[path].is_kind_of? Directory
      
         #$stderr.puts "directory: => #{path}"
         #$stderr.puts   @media.inode_of[path].is_kind_of? Directory
      
    end
  
    def read_file(path)
   #   puts "read_file: => #{path}"
    "Hello, World!\n"
    end

    def size(path)
    #  puts "size: => #{path}"
    read_file(path).size
    end

    
end        
flicklite = Flickruby.new
FuseFS.set_root( flicklite)

# Mount under a directory given on the command line.
FuseFS.mount_under ARGV.shift
FuseFS.run   

