#!/usr/bin/ruby
require 'rubygems'
require 'inode'
require 'json'
require 'fusefs'
require 'yaml'
##  create arbo ###
class Flickruby
   attr_accessor :media, :JSONset
   def initialize(tmpdir,mountpoint)
      @media=Table_inodes.new(mountpoint)
      @media.add_directory "/"
      my_sets= YAML::load File.open("#{tmpdir}/sets.yaml")
      @media.parse(my_sets)
      my_photos= YAML::load File.open("#{tmpdir}/photos.yaml")
      @media.parse_a_set(my_photos)
      #dump
   end
   def dump
      @media.dump
   end
   #################  fuse api
   def contents(path)
      list= @media.directory_content(path)
      #puts "contentss :#{path} -> #{list.inspect}"
      list
   end

   def file?(path)
      # puts  "file ? #{path}   #{@media.inode_of[path].kind_of? Afile} "
      @media.inode_of[path].kind_of? Afile

   end
   def directory?(path)
      #      puts  "directrory ? of #{path} #{@media.inode_of[path].kind_of? Directory}"
      @media.inode_of[path].kind_of? Directory
   end

   def read_file(path)
      #     puts "read_file: => #{path}"
      "hello?"
   end

   def size(path)
      #    puts "size: => #{path}"
      read_file(path).size
   end


end
flicklite = Flickruby.new(ARGV[1],ARGV[0])
FuseFS.set_root( flicklite)

# Mount under a directory given on the command line.

FuseFS.mount_under ARGV.shift
FuseFS.run

