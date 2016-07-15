require 'agendaHexe.rb'
filtre = ARGV.pop  ## toujours à la fin
puts ARGV.inspect
contenu = []
contenu = ARGF.readlines
agenda = Agenda.new(contenu)agenda.filtre_critere(filtre)