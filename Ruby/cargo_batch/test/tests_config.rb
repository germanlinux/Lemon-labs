require "minitest/autorun"
$LOAD_PATH << '../lib/'
#$LOAD_PATH << './'
#$LOAD_PATH << '../'
require "cargo_batch"
class Testconf <  MiniTest::Unit::TestCase
 def setup    
    @h ={}
    @h['t_argv'] = ['famille', 'nom', 'type', 'cle1' , 'valeur1','cle2','valeur2']
    @h['traitement'] = {'type' => 'caseof', 'pivot' => 'type',
                'dispatch' => {'modele' => 'add_modele.rb' ,'pdf' => 'add_pdf.rb' , 'source' => 'add_source.rb'}}               
   @cargo =  Cargo.new(@h.to_json)
 end  
###
def test_instance
    assert_equal @cargo.class, Cargo 
end
def  test_conf
    assert_equal  @cargo.type_of_job , 'caseof'  
end
def test_pivot
   assert_equal  @cargo.get_pivot , 'type' 
end   
def test_rang_pivot
   assert_equal  @cargo.get_rang_pivot , 2 
end   
def test_add_param_fail
  assert_raises (RuntimeError) { @cargo.add_argv([1,7])}
end   
def test_add_param_ok
    assert_silent { @cargo.add_argv([1,2,'modele',4,5,6,7])}
    assert_equal @cargo.param_nomme,{"famille"=>1, "nom"=>2, "type"=>'modele', "cle1"=>4, "valeur1"=>5, "cle2"=>6, "valeur2"=>7}
end   
def test_line
     @cargo.add_argv([1,2,'modele',4,5,6,7])
     assert_equal @cargo.build_line_pivot , "add_modele.rb 1 2 4 5 6 7"
end
def test_run
     @cargo.add_argv([1,2,'modele',4,5,6,7])
     assert_equal @cargo.run , "add_modele.rb 1 2 4 5 6 7"
end

end 

