require 'json'
filtre = ARGV.pop
files =[]
Dir.glob("#{filtre}*").each do|f|
 name = File.basename(f)
 files<< name
end
t = JSON.pretty_generate(:lib => filtre , :contents => files) 
puts t
