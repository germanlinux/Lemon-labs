#!/usr/bin/ruby
$: <<"./"
require 'rubygems'
source = SourceHTML.new(ARGV[0])
motif= ""
(nb, tabl) =  source.recherche motif(motif)
doccible= Metadata.new(ARGV[1])

