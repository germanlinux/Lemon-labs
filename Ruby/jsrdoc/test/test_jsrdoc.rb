require 'rubygems'
require 'helper'
$: <<"../lib/"
$: <<"."

puts $:

require 'sourcehtml'
require 'metadata'
class TestJsrdoc < Test::Unit::TestCase
#  should "probably rename this file and start testing for real" do
#    flunk "hey buddy, you should probably rename this file and start testing for real"
#  end
  def test_recup_source
   assert_equal  0, SourceHTML.new('nofileHTML').tableauligne.size
  end
  def test_recup_metadata
   assert_raise (RuntimeError) { MetaData.new('nofile')}
  end
  def test_lecture
    assert_equal  314, SourceHTML.new('accueil.ex.html').tableauligne.size   
  end
#  def test_regexp_fail
#     s1=  SourceHTML.new('accueil.ex.html')
#     assert_not_equal "rtt" ,s1.motifjs("script type=\"gghfdg")
#  end
  def test_regexp_ok
    s1=  SourceHTML.new('accueil.ex.html')
      s1.recherchemotifjs
     assert_equal 5 ,s1.lignejs.size
    s1.formatelignejs
       assert_equal 5 , s1.javascript.size 
  end  
end
