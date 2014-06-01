require 'rubygems'
require 'sinatra'
require 'json'
$LOAD_PATH << 'lib/'
require 'driverSQLITE'
#bundle exec ruby app.rb 
#
configure do
    set :bind ,'0.0.0.0'
    set :port , 4444
#  enable :sessions
end
get '/applications/list' do
   @tapplications = Tapplication.all
   erb :application
end
get '/programmes/list' do
 content_type :json
   
    response.write(Tpgm.all.to_json)
end
get '/ang1'  do
    erb :pgmang
end
get '/jobs/list' do
 content_type :json
    response.write(Tjob.all.to_json)
end    

get '/ang2'  do
    erb :jobang
end    