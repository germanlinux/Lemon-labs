require "minitest/autorun"
$LOAD_PATH << './'
require 'utildate.rb'
class Testdate <  MiniTest::Unit::TestCase
    def setup
       @chaine_date = "14-04-2014"
       @test_date = Util_date.new(@chaine_date)
    end
    def test_instance
        assert_equal @test_date.date.class, Date 
    end
    def test_date_debut
        assert_equal @test_date.semaine ,16  
    end
end