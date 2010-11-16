#!/usr/bin/ruby
require 'rubygems'
require 'sinatra'
require 'yaml'
require 'nosql'

 get '/status' do
    "{\"reponse\":\"nosql on the web version 1.0\"}"
 end
 get '/'    do 
   "<h3>Welcome in nosql on the web</H3>Actives locations :<br> <a href=/status> status</a>
    <br><a href=/config>config</a><br><a href=/populate>Populate</a><br><a href=/delete_row>Delete_row</a>"


 end
 get '/config' do
  dbconfig= YAML::load(File.open('database.yml'))
  schema= Nosql.new(dbconfig)
  schema.config
 end 
 get '/populate' do
  dbconfig= YAML::load(File.open('database.yml'))
  schema= Nosql.new(dbconfig)
  schema.collecte_all
  "{\"reponse\":\"ok\"}"
 end 
get '/delete_row' do
  dbconfig= YAML::load(File.open('database.yml'))
  schema= Nosql.new(dbconfig)
  schema.delete_row
"{\"reponse\":\"ok\"}"
 end 
