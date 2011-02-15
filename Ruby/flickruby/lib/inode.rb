class Inode
	attr_accessor :nlink,:mode,:ctime,:mtime ,:uid,:gid,:size,:id
	def initialize(id=0, size=0 )
		@nlink =1
		#@mode= mode
		@id=id
#		time = Time.now
#		@ctime= time
#		@mtime= time
		@blocksize= 4*1024
		#@uid= Process.uid
		#@gid= Process.gid
		@size= size
	end
    def inc_nlink 
        @nlink +=1 
    end
end
class Directory< Inode
	attr_accessor :path, :parent,:complete_path,:nphoto,:nvideo, :is_set,:secret
	def initialize (xpath,secret=0,id=0,nbp=0,nbv=0)
		super(id)
		@complete_path= xpath 
		tab=xpath.split('/') 
		if tab.size==0 then
			@parent=@path="/"
		else 
			@parent = tab.slice(0,tab.size-1).join('/')
		@parent= '/' if @parent.empty?
		@path =tab[-1]
		end
	end	
   
end
class Afile< Inode
	attr_accessor :complete_path, :parent, :title,:path
	def initialize (xpath,title, id=0)
		super(id)
		@complete_path= "/sets/#{xpath}/#{title}"
		@parent= "/sets/#{xpath}"
		@path= xpath
		@title= "#{title}.jpeg"
		@id=id
	end	
end
class Table_inodes 
	attr_accessor :inode_of,:root,:set
	def initialize(root)
	 @inode_of=Hash.new
	 @set = Hash.new
	 @root= root
	 @inode_of['/']=Directory.new('/')
 	end 
 	def add_directory(path,secret=0,id=0,isset=false,nbp=0,nbv=0) 
 	    if path =='/' then 
 	        my_path= "/sets"
 	    else
 	        
 	    my_path="/sets/#{path}" 
 	    end
 	    @inode_of[my_path] = Directory.new(my_path,secret,id,nbp,nbv) 
 	    @set[id]=path
 	    pr= @inode_of[my_path].parent
 	    @inode_of[pr].inc_nlink
 	    @inode_of[my_path].is_set=isset
 	end
 	def dump
 	    @inode_of.each do  |key, value|
 	        puts "#{key} => #{value.class} #{value.path} - #{value.parent} - #{value.complete_path}" 
 	    end 
 	end
    def directory_content(path)
        list =Array.new
        @inode_of.each do |key,value|
            next if key =='/'
            if  value.parent == path then 
                list<< value.path if value.kind_of? Directory
                list<< value.title if value.kind_of? Afile
              end    
            end     
        list
    end    
    def add_file(path,title,id,flag=0) 
        if flag == 1 then 
        t_path= "/sets/#{path}/#{title}.jpeg"
    else 
        t_path= "#{path}/#{title}.jpeg"
    end    
        @inode_of[t_path]= Afile.new(path,title,id)
    end
    def parse(hash_of_sets)
            hash_of_sets.each do |a_key,a_value| 
            my_id= a_key
            ## sanitize title 
            titre=  a_value["title"].gsub('/','-')
            #        my_path="/sets/#{titre}"
            nb_photo= a_value["photos"]
            nb_video= 0            
            secret = a_value["secret"]
            add_directory(titre,secret,my_id,true,nb_photo,nb_video)
        end
    
    end
    def parse_a_set(hash_of_picture)
        hash_of_picture.each do |key,a_set| 
            my_idset,my_idphoto= key.split('_')
            ## sanitize title 
            #puts a_set["title"] 
            title=  a_set["title"]
            #my_path="/sets/#{set}/#{titre}"
            set = @set[my_idset.to_i]         
            add_file(set,title,my_idphoto,1)
        end
    
    end     
    
end

