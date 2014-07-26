Xml = require './xml'
fs = require 'fs'
mydoc = fs.readFileSync 'profind_request.xml'
xmldoc = mydoc.toString()
options =[]
Xml.loadDOMDocument xmldoc,'', (err, dom) -> 
                    firstChild = dom.firstChild
                    c = firstChild.nextSibling.childNodes
                    #console.log c
                    for i in [1..c.length-1]
                     #console.log i  
                     options.push c[i].localName  if c[i].localName
console.log options