#!/usr/bin/ruby
require 'rubygems'
require 'sinatra'

 get '/status' do
    "nosql on the web version: 1.0"
 end
 get '/'    do 
   "Welcome in nosql on the web<br>Actives locations : <a href=/status> status</a>" 
 end
 
