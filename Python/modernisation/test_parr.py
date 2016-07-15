import unittest
from datetime  import date
from mparr import *


class TestChargeParr(unittest.TestCase):
    def test_load(self):
        dateref = date.today()
        parr = Parr(dateref)
        parr.charge_from_BDD()
        self.assertEqual(len(parr.lignes), 89)
        self.assertEqual(parr.lignes['102'].cparcgf,'E')
    def test_recherche(self):
        dateref = date.today()
        parr = Parr(dateref)
        parr.charge_from_BDD()
        self.assertEqual(parr.recherche('078','SPARADT'),'E4751411 ')

if __name__ == '__main__':
    unittest.main()
