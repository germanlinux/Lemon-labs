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
# puts datef , date_to_compare
@cp = 0
body = 1 
while (pivot == 0) 
 chaine = @content[@cp]
 puts chaine
 if  chaine =~ /BEGIN:VEVENT/
  pivot =1 
end
@cp = @cp+ 1     
end
#puts "eg" , @cp
#@cp = @cp-1
while (pivot  == 1)
  chaine = @content[@cp]
#  puts "eg", chaine
  re  = /DTSTART;TZID=Europe\/Paris:(.+)/
  m =  re.match chaine 
  dtstart  = m[1]
  re =  /(\d+)T(\d+)/
  dateRE = re.match dtstart 
  tdate = dateRE[1]
#  puts datef , tdate
tpivot =0 
if datef >= tdate then
#        puts "debut boucle"
#@cp = @cp - 1
while (tpivot ==0 )
#            puts "je saute"
@cp =@cp + 1 
chaine = @content[@cp] 
#            puts chaine 
if  chaine =~ /BEGIN:VEVENT/
  tpivot =1 
end
end
else 
 pivot =0
#         puts "mode impression" 
#         puts "BEGIN:VEVENT"
#puts chaine
@cp = @cp - 2
end  
    @cp = @cp + 1
 #   puts "fin de boucle"
end
#@cp = @cp - 1
while (@cp < @content.size) 
@cp = @cp + 1
chaine =  @content[@cp]
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

### recup parametre
  filtre = ARGV.pop  ## toujours à la fin
#if ARGV.size > 0   
#  file = ARGV.pop 
#end
#puts ARGF.inspect
#puts ARGF.read

#file = ARGV[0]
#filtre = ARGV[1]

#agenda = Agenda.new(file) 
#puts agenda.version 
#puts agenda.get_nb_event
#agenda.liste_date
#agenda.filtre_critere(filtre)
#puts filtre
#puts file
contenu = []
contenu = ARGF.readlines
#puts contenu
agenda = Agenda.new(contenu)
#puts agenda.version 
#puts agenda.get_nb_event
#agenda.liste_date
agenda.filtre_critere(filtre)