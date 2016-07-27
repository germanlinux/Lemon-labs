from datetime import date
class PseudoEcriture:
    _NHECLGSC = 0
    def __init__(self):
       self.SPSENCPT = "0"
    def set_NUMDEP(self,valeur):
        self.NUMDEP = valeur
    def set_SPSENCPT(self,valeur):
        self.SPSENCPT = valeur
    def set_DCRODEN(self,valeur):
            if type(valeur) is not date and not None:
                raise RuntimeError("{}  n est pas un format date".format(valeur))
            self.DCRODEN = valeur
    def set_DCROOPE(self,valeur):
            if type(valeur) is not date and not None:
                raise RuntimeError("{}  n est pas un format date".format(valeur))
            self.DCROOPE = valeur
    def set_DHECCOMP(self,valeur):
            if type(valeur) is not date and not None:
                raise RuntimeError("{}  n est pas un format date".format(valeur))
            self.DHECCOMP = valeur
    def set_CPSECCLI(self,valeur):
             self.CPSECCLI = valeur
    def set_NCROOPER(self,valeur):
             self.NCROOPER =valeur
    def set_ccrolop(self,valeur):
             self.CCROLOP= valeur
    def set_LHECSPE1(self,valeur):
             self.LHECSPE1 =valeur
    def set_LHECSPE2(self,valeur):
             self.LHECSPE2 =valeur
    def set_CPSEIMPE(self,valeur):
             self.CPSEIMPE = valeur
    def set_NHECLGSC(self,valeur):
             self.NHECLGSC= valeur
    def set_CZVSERLG(self,valeur):
             self.CZVSERLG = valeur
    def set_NCRODEN(self,valeur):
             self.NCRODEN = valeur
    def set_DCRODEN(self,valeur):
             self.DCRODEN = valeur
    def set_CCRODEN(self,valeur):
             self.CCRODEN = valeur
    def set_LCTATARU(self,valeur):
             self.LCTATARU =valeur
    def set_poste(self,valeur):
             self.poste_ = valeur
    def set_cleycte(self,valeur):
             self.ycte = valeur
    def set_CPSECOMA(self,valeur):
             self.CPSECOMA = valeur
    def set_CPSEIMPE(self,valeur):
             self.CPSEIMPE=valeur
    def set_DCROVAL(self,valeur):
             self.DCROVAL=valeur
    def set_CHECSNS(self,valeur):
             self.CHECSNS = valeur
    def set_MCROOPE(self,valeur):
             self.MCROOPE = valeur
    def efface_pseudo(self):
        """ emule le M462323"""
        self.set_LCTATARU('')
        self.set_CCRODEN('')
        self.set_DCRODEN(None)
        self.set_NCRODEN('')
        self.set_LHECSPE2('')
        self.set_LHECSPE1('')
        self.set_CPSEIMPE('0')
        self.inc_NHECLGSC()
        self.set_CZVSERLG('')
    def get_dcroope_str(self):
        tdate=self.DCROOPE.strftime("%Y%m%d")
        return tdate
    def get_dheccomp_str(self):
        tdate=self.DHECCOMP.strftime("%Y%m%d")
        return tdate
    def get_dcroval_str(self):
        tdate=self.DCROVAL.strftime("%Y%m%d")
        return tdate
    def set_lhecpart(self,valeur):
        self.lhecpart = valeur
    def set_lhecsep(self,valeur):
         self.lhecsep= valeur
    def set_scro1np1(self,valeur):
         self.scro1np1 = valeur
    def set_LHECSPE1(self,valeur):
         if valeur == 'tout_espace':
              valeur= ' '*12
         self.LHECSPE1 = valeur
    def set_LHECSPE2(self,valeur):
         if valeur == 'tout_espace':
              valeur= ' '*12
         self.LHECSPE2 = valeur
    def set_DCROREF(self,valeur):
          self.DCROREF = valeur
    def set_lheclibe(self,valeur):
          if valeur == 'tout_espace':
              valeur= ' '*30
          self.lheclibe =valeur
    def set_lheclib2(self,valeur):
          if valeur == 'tout_espace':
              valeur= ' '*30
          self.lheclib2 =valeur
    def set_checnot(self,valeur):
         self.checnot= valeur
    def set_checexo(self,valeur):
         self.checexo= valeur
    def set_ccrosche(self,valeur):
         self.ccrosche= valeur
    def _repr_(self):
        print("{};{}".format(self.NUMDEP,self.SPSENCPT ))
    def __str__(self):
        return ("{};{};{};{};{};{};{};{};{};{};{};{};{};{};{};{}{}{};{};{};{};{};{};".format(self.NUMDEP,self.SPSENCPT,self.get_dcroope_str(),self.NCROOPER,self.CCROLOP,self.NHECLGSC,self.poste_ ,\
        self.ycte,self.get_dheccomp_str(),self.CPSECCLI,self.CPSECOMA,self.CPSEIMPE,self.get_dcroval_str(),self.MCROOPE,self.CHECSNS,self.lhecpart, \
        self.lhecsep, self.scro1np1, self.lheclibe, self.lheclib2,self.ccrosche, self.checexo,self.checnot))
class StockageEcriture:
    def __init__(self):
        self.stockage=[]
    def add(self,item):
        self.stockage.append(item)
    def reset(self):
        self.stockage=[]


