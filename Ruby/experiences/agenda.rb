class Evenement
  require 'date'
  attr :dtstart , :summary , :location , :file, 
  :dtstamp , :date_clair , :time_clair

  def initialize(start, summ, loc, stamp  )
    @dtstart = start 
    @summary = summ
    @location = loc
    @dtstamp = stamp  
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
 def initialize (flux)
  @file =flux 
  myfile = File.open(@file)
  entete = 0
  body = 1 
  while (entete == 0) 
    chaine = myfile.readline
    if  chaine =~ /BEGIN:VEVENT/
      entete =1
      body = 0
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

  end
  dtstart  =0
  summary  =0
  location =0
  dtstamp  =0

  while (body == 0)
    chaine = myfile.readline
  #  puts chaine
  #  puts "suite"
  if  chaine =~  /END:VCALENDAR/ 
   body = 1
 end
 if  chaine =~  /END:VEVENT/ 
   event = 1
    # create event
 #      puts "j arrive"
 #     puts summary
 #     puts summary , location , dtstamp 
 tmpevent = Evenement.new(dtstart, summary, location, dtstamp) 
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
myfile.close

end 
def add_event (event) 
 @@liste_event << event
end  
def get_nb_event
 @@liste_event.size
end 
def filtre_critere(filtre)
 pivot =0
 date_to_compare = filtre
 datef = formate(date_to_compare)
#   puts datef , date_to_compare
myfile = File.open(@file)
body = 1 
while (pivot == 0) 
 chaine = myfile.readline
 puts chaine
 if  chaine =~ /BEGIN:VEVENT/
  pivot =1 
end     
end
while (pivot  == 1)
  chaine = myfile.readline
  re  = /DTSTART;TZID=Europe\/Paris:(.+)/
  m =  re.match chaine 
  dtstart  = m[1]
  re =  /(\d+)T(\d+)/
  dateRE = re.match dtstart 
  tdate = dateRE[1]
#    puts datef , tdate
tpivot =0 
if datef >= tdate then
#        puts "debut boucle"
while (tpivot ==0 )
#            puts "je saute"
chaine = myfile.readline 
#            puts chaine 
if  chaine =~ /BEGIN:VEVENT/
  tpivot =1 
end
end
else 
 pivot =0
#         puts "mode impression" 
#         puts "BEGIN:VEVENT"
puts chaine
end  
#    puts "fin de boucle"
end 
while (chaine = myfile.gets)
 puts chaine
end
end
def formate(tdate)
  tdatex =  tdate[4,4] + tdate[2,2] + tdate[0,2]  
end

def liste_date
 @@liste_event.each {|e|  puts e.affiche_date }
end
end

file = ARGV[0]
filtre = ARGV[1]

agenda = Agenda.new(file) 
#puts agenda.version 
#puts agenda.get_nb_event
#agenda.liste_date
agenda.filtre_critere(filtre)
