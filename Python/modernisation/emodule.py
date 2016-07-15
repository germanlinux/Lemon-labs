from datetime  import date
from mpcta   import *
from mpseudo import *
from mdfjc   import *
from mcro    import *
from mparr  import *
from mycte import *
_dateDeComptabilisation =''
def main():
    conn = psycopg2.connect("dbname='cep' user='postgres'   password ='pass' host ='192.168.99.100' ")
    cur = conn.cursor()
    # prendre la date de traitement : ici la date machine
    dateref = date.today()
    #chargement des tables
    #chargement pcta
    pcta = Pcta(dateref)
    pcta.charge_from_BDD()
    #calcul des schema comptable
    schema = SchemaComptable(pcta)
    #charge table parr
    parr = Parr(dateref)
    parr.charge_from_BDD()
    #charge table ycte
    ycte = Ycte(dateref)
    ycte.charge_from_BDD()


    #module MA82323
    #calcul journee complementaire
    dfjc = Dfjc()
    _dateDeComptabilisation = dfjc.get_datecompabilisation(dateref)
    # fin module MA82323
    cur.execute("SELECT * FROM CRO_C23121A ORDER BY  numdep ,dcroope, ncrooper, ccrolop;")
    for record in cur:
        #print(record)
        croatraiter = Cro(record)
        print("--------------------------------------------------------------------------------")
        croatraiter.infocpte()
        croatraiter.ajusteCro_ano()
        compta = schema.recherche_operation(croatraiter.cle_pcta())
        clefinale= compta[0].CCROLOP+compta[0].CTCLI+compta[0].CCROANOC
        cleycte =croatraiter.CCPTIND +   croatraiter.SCPTTYP
        print("nb d ecriture comptable à generer:{}   reference PCTA: {} type de compte:{}".format(len(compta),clefinale,cleycte))
        cpligne =0
        for ligne in compta:
            cpligne+=1
            if cpligne != ligne.get_nctalgns():
                raise RuntimeError("Numero de ligne schema incoherent")
            ecr = PseudoEcriture()
            ecr.set_NUMDEP(croatraiter.numdep)
            ecr.set_NCROOPER(croatraiter.NCROOPER)
            ecr.set_ccrolop(croatraiter.CCROLOP)
            ecr.set_NHECLGSC(str(cpligne).zfill(2))
            ecr.set_poste(croatraiter.POSTE_)
            ecr.set_cleycte(cleycte)
            _spsencpt1 = ligne.get_cctamafi()
            _spsencpt2 = ligne.get_lctataru()
            ecr.set_DCROOPE(croatraiter.DCROOPE)
            if _spsencpt1 == 'CRO' and _spsencpt2 == 'SCPT1002':
                ecr.set_SPSENCPT(croatraiter.get_compte())
                #print(ecr.SPSENCPT)
            elif _spsencpt1 =='CTABPARR':
                contrepartie = parr.recherche(croatraiter.CBOPCONT, _spsencpt2)
                ecr.set_SPSENCPT(contrepartie)
            elif _spsencpt1 =='CTABYCTE':
                contrepartie = ycte.get_syctclass(cleycte)
                ecr.set_SPSENCPT(contrepartie)
            else:
                raise RuntimeError("TODO:{}".format(_spsencpt1))
            print("ecriture num:{}".format(cpligne))
            print(ecr)

main()
