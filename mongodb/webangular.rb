require 'rubygems'
require 'sinatra'
require 'json'
$LOAD_PATH << 'lib/'
require 'driverSQLITE'
#bundle exec ruby app.rb 
#
configure do
    set :bind ,'0.0.0.0'
    set :port , 5555
    
#  enable :sessions
end
get '/' do
 content_type 'text/html'    
 File.read(File.join('public', 'index.html'))
end
get '/programmes/list' do
 content_type :json   
 response.write(Tpgm.all.to_json)
end
get '/jobs/list' do
 content_type :json
    response.write(Tjob.all.to_json)
end    
get '/applications/list' do
 content_type :json   
 response.write(Tapplication.all.to_json)
end
get '/jcl/list' do
 content_type :json
    response.write(Tjcl.all.to_json)
end    
get '/fetch/list' do
 content_type :json
    response.write(Tfetch.all.to_json)
end    
get '/step/list' do
 content_type :json
    response.write(Tstep.all.to_json)
end    
get '/exec/list' do
 content_type :json
    response.write(Texec.all.to_json)
end
get '/files/list' do
 content_type :json
    response.write(Tfile.all.to_json)
end
get '/files/list/:offset' do
 seg = params[:offset].to_i * 6000    
 content_type :json
    response.write(Tfile.all(:limit => 6000 ,:offset => seg).to_json)
end
get '/files/like/:offset' do
 seg ='%' + params[:offset]+'%'     
 content_type :json
    response.write(Tfile.all(:dsname.like => seg , :limit => 6000).to_json)
end




