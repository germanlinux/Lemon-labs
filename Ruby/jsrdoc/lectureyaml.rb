require 'rubygems'

$: << "lib/"
$: <<"."

puts $:

require 'sourcehtml'
require 'metadata'
fmd= MetaData.new("opera")
fmd.write(s1.file, s1.javascript)
