from datetime import date
class Cro:
    def __init__(self,crobase):
     self.id = crobase[0]
     self.CCROLOP = crobase[1]
     self.CTCLI =    crobase[2]
     self.CCROANOC = crobase[3]
     self.POSTE_   = crobase[4]
     self.CCPTIND   = crobase[5]
     self.COMPTE_  = crobase[6]
     self.SCPTTYP  = crobase[7]
     self.CCRODENO = crobase[8]
     self.DCRODENO = crobase[9]
     self.NCRODENO = crobase[10]
     self.CBOPNOTA = crobase[11]
     self.CCRODENI_1 = crobase[12]
     self.DCRODENI_1 = crobase[13]
     self.NCRODENI_1 = crobase[14]
     self.DCROOPE  = crobase[15]
     self.DCROVAL  = crobase[16]
     self.DCROREF  = crobase[17]
     self.NCROOPER  = crobase[18]
     self.numdep    = crobase[19]
     self.NCROREF =  crobase[20]
     self.CCRONOTI_1 = crobase[21]
     self.CBOPCONT = crobase[22]
    def ajusteCro_ano(self):
     """emule le M752323"""
     niveau = int(self.CCROANOC)
     if not niveau <  3:
          niveau -=3
          self.CCROANOC= str(niveau)
     return  self.CCROANOC
    def notageBool(self):
     if  self.CBOPNOTA > 0:
         return  True
     else:
         return False
    def ecritureExtourneBool(self):
     """emule la C412323"""
     if  self.NCROREF  > 0 and self.DCROREF is not None:
         return  True
     else:
         return False
    def cle_pcta(self):
         return(self.CCROLOP+self.CTCLI+self.CCROANOC)
    def get_compte(self):
         return(self.POSTE_+self.CCPTIND+self.COMPTE_)
    def confectionNotageBool(self):
     """emule la C252323"""
     if self.CCRONOTI_1 == 'I' and self.CCRODENI_1 =='9999' and self.DCRODENI_1 is not None:
        return True
     else:
        return False
    def infocpte(self):
     print("Cro à traiter: operation:{} sur compte {} du departement:{}".format(self.cle_pcta(),self.get_compte(),self.numdep))

