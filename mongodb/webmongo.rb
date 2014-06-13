require 'rubygems'
require 'sinatra'
require 'json'
$LOAD_PATH << 'lib/'
#bundle exec ruby app.rb 
#

require 'mongo'
include Mongo
configure do
    set :bind ,'0.0.0.0'
    set :port , 6789
    
#  enable :sessions
end
before do
 @connect = MongoClient.new("localhost",27017) 
 @db = @connect.db('paye2')
end

get '/' do
 content_type 'text/html'    
 File.read(File.join('./','index.html'))
end

get '/jobs/list' do
 @appli =  @db['entites'].find({'_type' => 'jcl'}).sort({:nom => 1}).to_a
 content_type :json
 response.write(@appli.to_json)
end    
get '/applications/list' do
 @appli =  @db['entites'].find({'_type' => 'application'}).sort({:ordre => 1}).to_a
 content_type :json
 response.write(@appli.to_json)
end
get '/fetchs/list' do
 @appli =  @db['entites'].find({'_type' => 'fetch'}).sort({:nom => 1}).to_a
 content_type :json
 response.write(@appli.to_json)
end
get '/execs/list' do
 @appli =  @db['entites'].find({'_type' => 'exec'}).sort({:pgm => 1}).to_a
 content_type :json
 response.write(@appli.to_json)
end
get '/steps/list' do
 @appli =  @db['entites'].find({'_type' => 'step'}).sort({:nom => 1}).to_a
 content_type :json
 response.write(@appli.to_json)
end
