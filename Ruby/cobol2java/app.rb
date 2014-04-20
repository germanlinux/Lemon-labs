require 'rubygems'
require 'sinatra'
require 'mongo'
include Mongo
#bundle exec ruby app.rb 
#
configure do
    set :base , 'vfp'
#  enable :sessions
end
before do
  @connect = MongoClient.new("localhost",27017) unless @connect
  puts settings.base
  @db = @connect.db(settings.base)
  @jcl =  @db['jcl'].find().sort({:jcl => 1}).to_a;  
end    
#helpers do
#  def username
#    session[:identity] ? session[:identity] : 'Hello stranger'
#  end
#end

#before '/secure/*' do
#  if !session[:identity] then
#    session[:previous_url] = request.path
#    @error = 'Sorry guacamole, you need to be logged in to visit ' + request.path
#    halt erb(:login_form)
#  end
#end
get '/' do 
redirect to ("/jcl")
end  
get '/jcl' do
  @jcl
  erb :jcl
end

#get '/login/form' do 
#  erb :login_form
#end

#post '/login/attempt' do
#  session[:identity] = params['username']
#  where_user_came_from = session[:previous_url] || '/'
#  redirect to where_user_came_from 
#end

#get '/logout' do
#  session.delete(:identity)
#  erb "<div class='alert alert-message'>Logged out</div>"
#end


#get '/secure/place' do
#  erb "This is a secret place that only <%=session[:identity]%> has access to!"
#end
