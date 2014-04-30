$LOAD_PATH << '../lib/'
#$LOAD_PATH << './'
#$LOAD_PATH << '../'
require "cargo_batch"
h ={}
h['argv'] = ['famille', 'nom', 'type', 'cle1' , 'valeur1','cle2','valeur2']
h['traitement'] = ['type' => 'caseof', 'pivot' => 'type',
                'dispatch' => ['modele' => 'add_modele.rb' ,'pdf' => 'add_pdf.rb' , 'source' => 'add_source.rb'] ]



###
cargo = Cargo.new(h.to_json)
cargo.run


