require 'rubygems'
require 'sinatra'
require 'json'
#bundle exec ruby app.rb 
#
configure do
    set :bind ,'0.0.0.0'
    set :port , 4567
    
#  enable :sessions
end
get '/index.html' do
 content_type 'text/html'    
 File.read(File.join('./', 'index.html'))
end
