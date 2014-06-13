#!/bin/bash
## remove collection base paye2
#  > use paye2
#  switched to db paye2
#  > show collections
#  entites
#  system.indexes
#  > db.entites.remove()
#  > db.entites.count()
#  0
#>
ruby migrate_appli.rb 
ruby migrate_chaine.rb 
ruby migrate_fetch.rb
ruby migrate_exec.rb
ruby exec_count.rb 
ruby jcl_count.rb 
ruby appli_count.rb



