require 'json'
require 'pathname'
########## lecture des jcl IBM Z/OS
# extraction du nom de jcl 
#r1  = /\/\/(.+?)\s/  
# extraction du nom des programmes du jcl
r2  = /PGM=(PA.+)/ 
r_jcl = /(.*)_JCL/
r_ext = /(.*)\./
r_path = /(.+)_/
path = ARGV.shift
Dir.glob(path).each do |filename| 
 t = Pathname.new(filename)
 direc = t.to_path
 tdirec = direc.split('/')
my_direc = tdirec[-2]
@domaine = my_direc
tmatchdir = my_direc.match r_path
@domaine = tmatchdir[1] if tmatchdir

 @file = t.basename.to_s
 tmatch = @file.match r_jcl
 tmatch2 =  @file.match r_ext
 if tmatch then 
  @jcl = tmatch[1]
 else
  @jcl = tmatch2[1]
 end 
 f= File.open(filename)
@tabpgm = []
hash={}
content = File.readlines(f)
content.each_with_index do |ligne,i|
    l2 = ligne.force_encoding("UTF-8")
    l2.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
    l2.encode!('UTF-8', 'UTF-16', :invalid => :replace)
    l2.chomp!
    begin
    tpgm = l2.match r2
    rescue
    end   
    if tpgm then 
          @tabpgm << tpgm[1]
     end
 end
hash[:file] = @file
hash[:jcl] = @jcl
hash[:pgm] = @tabpgm
hash[:source] = content
hash[:_type] = 'JCL'
hash[:domaine] = @domaine
puts hash.to_json
end 
