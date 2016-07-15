import unittest
from datetime  import date
from mdfjc import *


class TestChargeDFJC(unittest.TestCase):
    def test_load(self):
        dfjc = Dfjc()
        self.assertEqual(dfjc.dfinjcli.strftime('%Y-%m-%d'),'2016-01-05')
    def test_mois_jc_c402323_faux(self):
         tmpdate= date(2016,2,1)
         dfjc = Dfjc()
         self.assertEqual(dfjc.C402323(tmpdate),False)
    def test_mois_jc_c402323_vrai(self):
         tmpdate= date(2016,1,10)
         dfjc = Dfjc()
         self.assertEqual(dfjc.C402323(tmpdate),True)
    def test_dernierjourJC(self):
         dfjc = Dfjc()
         self.assertEqual(dfjc.MA92323().month,12)
         self.assertEqual(dfjc.MA92323().day,31)
         self.assertEqual(dfjc.MA92323().year,2015)
         self.assertEqual(dfjc._008DFINA.month,12 )
    def test_jc(self):
         dfjc = Dfjc()
         d1 = date(2016,1,4)
         self.assertEqual(dfjc.estenjourneecomplementaireBool(d1),True)
         self.assertEqual(dfjc.estenjourneecomplementaireBool(date(2016,1,5)),True)
         self.assertEqual(dfjc.estenjourneecomplementaireBool(date(2016,1,6)),False)
    def test_getdatecpt(self):
         dfjc = Dfjc()
         d1 = date(2016,1,4)
         self.assertEqual(dfjc.get_datecompabilisation(d1).strftime('%Y-%m-%d'),'2015-12-31')

if __name__ == '__main__':
    unittest.main()
