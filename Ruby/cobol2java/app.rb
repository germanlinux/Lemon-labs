require 'rubygems'
require 'sinatra'
require 'mongo'
include Mongo
#bundle exec ruby app.rb 
#
configure do
    set :base , 'vfp'
    set :bind ,'0.0.0.0'
#  enable :sessions
end
before do
  unless @connect    
  @connect = MongoClient.new("localhost",27017) 
  @db = @connect.db(settings.base)
  @jcl =  @db['jcl'].find().sort({:jcl => 1}).to_a
  @pgm =  @db['pgm'].find().sort({:nom => 1}).to_a   
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
get '/pgm' do
  @pgm
  erb :pgm
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
get '/analysepgm/:id' do
content_type 'application/octet-stream'
 @id_pgm =  params[:id]
 @pgm.each do |p|
   if p['_id'].to_s == @id_pgm  then 
      @p_pdf   = p['pdf']        
      break 
  end
 end

content_type 'application/pdf'
response.write(@p_pdf)
end
get '/pdfjcl/:id' do
content_type 'application/octet-stream'
 @id_jcl =  params[:id]
 @un_jcl = @jcl.select {|item|  item['_id'].to_s == @id_jcl}
@mon_jcl = @un_jcl[0]['pdf']
content_type 'application/pdf'
response.write(@mon_jcl)
end

get '/sourcepgm/:id' do
 @id_pgm =  params[:id]
 @pgm.each do |p|
   if p['_id'].to_s == @id_pgm  then 
      @nom_pgm =p['nom']
      @source  = p['source']        
      break 
  end
 end
  @source.map! do |ligne| 
   ligne.gsub!(/\r\n/, '<br>')
   ligne.gsub!(/\s/, '&nbsp;')
  end 
  erb :source 
end
get '/modelepgm/:id' do
 @id_pgm =  params[:id]
 @pgm.each do |p|
   if p['_id'].to_s == @id_pgm  then 
      @nom_pgm =p['nom']
      @step  = p['conf_step']
      @modele  = p['modele']        
      break 
  end
 end
content_type 'image/png'
response.write(@modele)
end
get '/modelejcl/:id' do
 @id_jcl =  params[:id]
 @jcl.each do |p|
   if p['_id'].to_s == @id_jcl  then 
      @modele  = p['modele']        
      break 
  end
 end
content_type 'image/png'
response.write(@modele)
end

get '/editjcl/:id'  do
 @id_jcl =  params[:id]
 @un_jcl = @jcl.select {|item|  item['_id'].to_s == @id_jcl}
 @e_jcl = @un_jcl[0]
  erb :editjcl
end

post '/jcl/:id' do
@id_jcl = params[:id]
cle = params[:cle]
valeur = params[:valeur]
res = @db['jcl'].update({'_id' =>  BSON::ObjectId(@id_jcl)  }, {"$set" => {cle  => valeur}})
redirect to ("/jcl") 
end

## Restful uri
##
delete '/pgm/:id'  do
@id_pgm =  params[:id]
@pgm =  @db['pgm'].remove('_id'  => BSON::ObjectId(@id_pgm) )
response.write ("{ok}") 
#curl -X DELETE http://localhost:4567/pgm/5352d84751514034cc000048
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
