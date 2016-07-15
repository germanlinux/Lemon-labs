import unittest
from datetime  import date
from mpcta import *


class TestChargePCATE(unittest.TestCase):
    def test_load(self):
        dateref = date.today()
        pcta = Pcta(dateref)
        pcta.charge_from_BDD()
        self.assertEqual(len(pcta.lignes), 1612)
        self.assertEqual(pcta.lignes['094DT0999902'].dtabval,date('1999-01-01'))


if __name__ == '__main__':
    unittest.main()
