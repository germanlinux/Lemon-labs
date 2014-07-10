#!/usr/bin/ruby
reg1 =  Regexp.new(/tablespace tbs_sag_.*?\s/)
ARGF.each_line do |l|
       l.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
       l.encode!('UTF-8', 'UTF-16', :invalid => :replace)
      tabmatch  = reg1.match(l)
      if tabmatch then 
         l.gsub!(/tablespace tbs_sag_.*?\s/,'')
      end
    l.gsub!(/using index/,'')
    l.gsub!(/^ +\r\n/,'')  
    puts l  if !l.empty?

end