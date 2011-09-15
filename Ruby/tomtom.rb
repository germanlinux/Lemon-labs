$: <<"./"
require 'rubygems'
require 'rytomtom'
require 'Qt4'
require 'metadata'
a = Qt::Application.new(ARGV)
param= MetaData.new('tomtom')

tomtom = RyTOMTOM.new
tomtom.starter(param)
tomtom.show
a.exec
