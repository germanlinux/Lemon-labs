#!/usr/bin/ruby
class Evenement
  require 'date'
  attr :dtstart , :summary , :location , :file, 
  :dtstamp , :date_clair , :time_clair, :nbdebut, :nbfin

  def initialize(start, summ, loc, stamp,nbd,nbf  )
    @dtstart = start 
    @summary = summ
    @location = loc
    @dtstamp = stamp
    @nbdebut = nbd
    @nbfin = nbf  
  end
  def affiche_date
   re =  /(\d+)T(\d+)/
   dateRE = re.match @dtstart 
   tdate = dateRE[1]
   @time_clair = dateRE[2]
   @date_clair  = tdate[6,2] + '/' + tdate[4,2] + '/' + tdate[0,4]
   @fdate = Date.new(tdate[0,4].to_i,   tdate[4,2].to_i, tdate[6,2].to_i)
   @date_clair
   
 end


end

class Agenda
 @@liste_event = []
 attr :version , :dateUnix_entete
 def initialize (lines)
  @cp = 0
  @content = lines 
  entete = 0
  body = 1 
  #puts "je pass1"
  while (entete == 0)  
    chaine = @content[@cp]
    #puts chaine
    if  chaine =~ /BEGIN:VEVENT/
      entete =1
      body = 0
      nbligneDEB = @cp
    end
    if  chaine =~  /X-OBM-TIME:/ 
      re =   /X-OBM-TIME:(.+)/
      m =  re.match chaine 
      @dateUnix_entete = m[1] 
    end
    if  chaine =~  /VERSION:/ 
      re =   /VERSION:(.+)/
      m =  re.match chaine 
      @version = m[1] 
    end
  @cp= @cp + 1
  end
 # puts "je passe"
  dtstart  =0
  summary  =0
  location =0
  dtstamp  =0
  @cp = @cp - 1
  
  while (body == 0)
    @cp = @cp + 1
    chaine = @content[@cp]

  #  puts chaine
  #  puts "suite"

  if  chaine =~  /BEGIN:VEVENT/ 
   nbligneDEB = @cp
  end
  
  if  chaine =~  /END:VCALENDAR/ 
   body = 1
  end
  if  chaine =~  /END:VEVENT/ 
   nbligneFIN = @cp
  
   event = 1
    # create event
 #      puts "j arrive"
 #     puts summary
 #     puts summary , location , dtstamp 
 #puts nbligneDEB, nbligneFIN
 tmpevent = Evenement.new(dtstart, summary, location, dtstamp,nbligneDEB,nbligneFIN) 
 add_event(tmpevent)
 event    =0
 dtstart  =0
 summary  =0
 location =0
 dtstamp  =0

end        
if chaine =~ /DTSTART/
#       puts "je passe aussi"
re  = /DTSTART;TZID=Europe\/Paris:(.+)/
m =  re.match chaine 
dtstart  = m[1]
#       puts dtstart 
end
if chaine =~ /SUMMARY/
 re  = /SUMMARY:(.+)/
 m =  re.match chaine 
 summary  = m[1] 
end
if chaine =~ /LOCATION/
 re  = /LOCATION:(.+)/
 m =  re.match chaine 
 location  = m[1] if m 
end
if chaine =~ /DTSTAMP/
 re  = /DTSTAMP:(.+)/
 m =  re.match chaine 
 dtstamp  = m[1] 
end


end

end 
def add_event (event) 
 @@liste_event << event
end  
def get_nb_event
 @@liste_event.size
end 
def get_first_event
 @@liste_event[0]
end  

def filtre_critere(filtre)
 pivot =0
 date_to_compare = filtre
 datef = formate(date_to_compare)
#cp = 0
## edition entete 
nbligne= get_first_event.nbdebut
#puts get_first_event.inspect
#puts nbligne
#while (cp < nbligne)
#  puts @content[cp]
#  cp = cp + 1 
#end

(nbligne).times do |x|
  puts @content[x]
end 
## boucle principale
@@liste_event.each do |un_event|
tmpdate = isole_date un_event.dtstart
  if tmpdate >= datef
     dep = un_event.nbdebut
     fin = un_event.nbfin
     (dep..fin).each { |e| puts @content[e]  }
   end 
end
puts @content[-1]
###
end
def formate(tdate)
  tdatex =  tdate[4,4] + tdate[2,2] + tdate[0,2]  
end
def isole_date(date)
  re =  /(\d+)T(\d+)/
  dateRE = re.match date 
  tdate = dateRE[1]
end 
def liste_date
 @@liste_event.each {|e|  puts e.affiche_date }
end
end

### recup parametre
filtre = ARGV.pop  ## toujours à la fin
puts ARGV.inspect
contenu = []
contenu = ARGF.readlines
agenda = Agenda.new(contenu)
agenda.filtre_critere(filtre)