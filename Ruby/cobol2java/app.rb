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
  unless @connect    
  @connect = MongoClient.new("localhost",27017) 
  @db = @connect.db(settings.base)
  @jcl =  @db['jcl'].find().sort({:jcl => 1}).to_a   
  end
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
get '/textejcl/:id' do
 @id_jcl =  params[:id]
 @un_jcl = @jcl.select {|item|  item['_id'].to_s == @id_jcl}
@mon_jcl = @un_jcl[0]['source']
@nom_jcl =@un_jcl[0]['jcl'] 

@mon_jcl.map! do |ligne| 
   ligne.gsub!(/\r\n/, '<br>')
end
  erb :visujcl 
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
