import unittest
from datetime  import date
from mpcta import *


class TestChargePCATE(unittest.TestCase):
    def test_load(self):
        dateref = date.today()
        pcta = Pcta(dateref)
        pcta.charge_from_BDD()
        self.assertEqual(len(pcta.lignes), 1612)
        self.assertEqual(pcta.lignes['094DT0999902'].dtabval.strftime('%Y-%m-%d'),'1999-01-01')
    def test_schemaPcta(self):
        dateref = date.today()
        pcta = Pcta(dateref)
        pcta.charge_from_BDD()
        schema = SchemaComptable(pcta)
        self.assertEqual(schema.recherche_operation('104DT0')[0].CTCLI,'99')

if __name__ == '__main__':
    unittest.main()
