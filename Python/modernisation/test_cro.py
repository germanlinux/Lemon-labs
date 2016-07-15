import unittest
from datetime  import date
from mcro import *


class TestCro(unittest.TestCase):
    def test_anocro2(self):
        cro = Cro((2,0,None,None,None,None,None))
        self.assertEqual(cro.ajusteCro_ano(),2)
    def test_anocro3(self):
        cro = Cro((3,0,None,None,None,None,None))
        self.assertEqual(cro.ajusteCro_ano(),0)
    def test_notage_faux(self):
        cro = Cro((3,0,None,None,None,None,None))
        self.assertEqual(cro.notageBool(),False)
    def test_notage_false(self):
        cro = Cro((3,23,None,None,None,None,None))
        self.assertEqual(cro.notageBool(),True)
    def  test_ecritureExtourne(self):
         cro= Cro((3,23,1,date.today(),None,None,None))
         self.assertEqual(cro.ecritureExtourneBool(),True)
    def  test_ecritureExtourneF(self):
         cro= Cro((3,23,0,1,None,None,None))
         self.assertEqual(cro.ecritureExtourneBool(),False)
    def  test_ecritureExtourneF(self):
         cro= Cro((3,23,1,None,None,None,None))
         self.assertEqual(cro.ecritureExtourneBool(),False)
    def test_confectionNotage1(self):
         cro= Cro((3,23,1,None,'I','9999',None))
         self.assertEqual(cro.confectionNotageBool(),False)
    def test_confectionNotage2(self):
         cro= Cro((3,23,1,None,'','9999',None))
         self.assertEqual(cro.confectionNotageBool(),False)
    def test_confectionNotage1(self):
         cro= Cro((3,23,1,None,'I','9999',date.today()))
         self.assertEqual(cro.confectionNotageBool(),True)


if __name__ == '__main__':
    unittest.main()
