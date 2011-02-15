require 'helper'
require 'inode'

class TestInode < Test::Unit::TestCase
	should "test require" do
	        eval "require 'inode'" 
		assert(true,"require OK")
	  end
	  should "test on create inode" do
	  	  ino= Inode.new
	  	  assert_kind_of(Time, ino.mtime)
	  	  assert_kind_of(Time,ino.ctime)
	  	  assert_equal ino.mode ,0o644
	  	  assert_match(/\d+/, ino.uid.to_s )
	  	  assert_match(/\d+/, ino.gid.to_s)
	  	  assert_equal 0, ino.size
	  	  assert_equal 1, ino.nlink
	  	  
	  end
	  should "test on create directory" do
	  	  ino= Directory.new("/")
	  	  assert_equal ino.mode ,0o755
	  	#  assert_equal 0, ino.size
	  	#  assert_equal 1, ino.nlink
	  	assert_equal '/', ino.parent
	  	assert_equal '/', ino.path
	  	ino= Directory.new("/sets")
	  	assert_equal '/', ino.parent
	  	assert_equal 'sets', ino.path
	  	ino= Directory.new("/sets/suite")
	  	assert_equal '/sets/suite', ino.complete_path
	  	assert_equal '/sets', ino.parent
	  	assert_equal 'suite', ino.path
	  	
	  	
	  end

	  should "test on create a file" do
	  	  ino= Afile.new("/set",'image1')
	  	  assert_equal ino.mode ,0o644
	  	#  assert_equal 0, ino.size
	  	#  assert_equal 1, ino.nlink
	  
	  	assert_equal '/set', ino.complete_path
	        assert_equal 'image1' ,ino.id 	
	  	
	  end

	  should "test on create a file system" do
	  	  table=Table_inodes.new("/media/flicruby")
	  	  assert_equal table.inode_of.size, 1
	  	  assert_equal table.inode_of["/"].parent , "/"
	  	#  assert_equal 1, ino.nlink
	  
	  	
	  end
	  should "test on add directory" do
	  	  table=Table_inodes.new("/media/flicruby")
	  	  table.add_directory "/sets"
	  	  assert_equal table.inode_of["/"].nlink ,2
	  	  assert_equal table.inode_of.size,2
	  	  table.add_directory "/stix"
	  	  assert_equal table.inode_of["/"].nlink ,3
	  	  assert_equal table.inode_of.size,3
	  	  table.add_directory "/stix/stax"
	  	  assert_equal table.inode_of["/stix"].nlink ,2
	  	  assert_equal table.inode_of.size,4
	  	  
	  	  
	  	  
	      table.dump
	  end
end
