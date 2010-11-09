#!/usr/bin/ruby
require 'rubygems'
require 'yaml'
require 'nosql'
dbconfig= YAML::load(File.open('database.yml'))
schema= Nosql.new(dbconfig)
puts schema.inspect
#dim=schema.get_list_dim

#champs=schema.get_field_fact
#champs=schema.get_field('projets')
#puts "fact"
#puts champs

#champs=schema.get_field('technos')
#puts "----------------------------------------"
#puts "dim technos"
#puts champs
#puts "-----------------------------------------"
#schema.collecte_all
#schema.collecte_dim('technos')
#schema.parse
#schema.complete_field_dim
#puts schema.inspect

