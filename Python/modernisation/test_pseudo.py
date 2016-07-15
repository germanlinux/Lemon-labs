import unittest
from datetime  import date
from mpseudo import *


class TestPseudo(unittest.TestCase):
    def test_date(self):
        ps = PseudoEcriture()
        self.assertEqual(ps.set_DCRODEN(date.today()),None)
        self.assertEqual(ps.set_DHECCOMP(date.today()),None)


if __name__ == '__main__':
    unittest.main()
