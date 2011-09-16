require 'rubygems'
$: <<"../lib/"
$: <<"."
puts $:
require 'sourcehtml'

      s1=  SourceHTML.new('../accueil.ex.html')
      s1.recherchemotifjs
      s1.formatelignejs

