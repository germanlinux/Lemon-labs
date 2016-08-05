class Rupture:
    def __init__(self,pivot):
      self.sauve = pivot
      self._debut = True
    def testeBool(self,courant):
      if self._debut == True:
          self.sauve = courant
          self._debut = False
          return False
      if self.sauve == courant:
          self.sauve = courant
          return False
      else:
          self.sauve = courant
          return True
    def reset(self,pivot):
      self.sauve = pivot
      self._debut = True
    def force_rupture(self):
       pass
