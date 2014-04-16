require 'date'
class Util_date    
attr_accessor :date 
    def initialize (chaine)
        @date  =  Date.strptime(chaine, '%d-%m-%Y')
    end    
def semaine
    @date.cweek
end

end

