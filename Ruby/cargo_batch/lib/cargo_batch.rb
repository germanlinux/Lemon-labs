$LOAD_PATH << './'
require "cargo_batch/version"
require 'json'

class Cargo
  attr_accessor  :param_nomme , :line
  def initialize(confjson)
    @conf  =JSON.parse(confjson)
    @param_nomme = {}
  end
  def type_of_job 
    @conf['traitement']['type']
  end  
  def get_pivot 
    @conf['traitement']['pivot']
  end  
  def get_rang_pivot
    @rg_pivot = 0
    tab = @conf['t_argv']
   
    tab.each_with_index do |l,i| 
      if l == get_pivot then
        @rg_pivot = i
        end
     end   
    @rg_pivot     
  end
  def add_argv(t)
    @argv = t
    if t.size != @conf['t_argv'].size then 
       raise "nombre de parametre incorrect"
    end
   @conf['t_argv'].each_with_index do |tz,i| 
     @param_nomme[tz]  =  t[i] 
   end       
  end 
  def build_line_pivot
    casex = @param_nomme[get_pivot]
    famillex = @param_nomme[get_pivot]
    prog = @conf['traitement']['dispatch'][casex] 
    line = " #{prog} "
    @argv.each do |a|
      prog += " #{a}" if a != casex
      
    end
    @line =  prog
       
  end
  def run
    if type_of_job == 'caseof'  then 
        command = build_line_pivot
        end    
   `ruby #{command}`
   #{}`ls *`
  end
  
  # Your code goes here...
end
