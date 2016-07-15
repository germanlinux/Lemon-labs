import unittest
from datetime  import date
from mycte import *


class TestChargeYcte(unittest.TestCase):
    def test_load(self):
        dateref = date.today()
        ycte = Ycte(dateref)
        ycte.charge_from_BDD()
        self.assertEqual(len(ycte.lignes), 248)
        self.assertEqual(ycte.lignes['01160'].syctcass,'E44118   ')
# def test_recherche(self):
#    dateref = date.today()
#   ycte = Yarr(dateref)
#  ycte.charge_from_BDD()
# self.assertEqual(ycte.recherche('01160'),'E4751411 ')

if __name__ == '__main__':
    unittest.main()
