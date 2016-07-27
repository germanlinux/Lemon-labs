from datetime  import date
from mpcta   import *
from mpseudo import *
from mdfjc   import *
from mcro    import *
from mparr  import *
from mycte import *
from mbope import *
from mrupture import *
from mcint import *
from mpsql import *

_dateDeComptabilisation =''
def main():
    fs  = open("./pseudoEGlinux.csv","w")
    conn = psycopg2.connect("dbname='cep' user='postgres'   password ='pass' host ='192.168.99.100' ")
    cur = conn.cursor()
    # prendre la date de traitement : ici la date machine
    dateref = date(2016,6,10)
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
    #charge bope
    bope = Bope(dateref)
    bope.charge_from_BDD()
    #charge cint
    cint = Cint(dateref)
    cint.charge_from_BDD()
    #charge psql
    psql = Psql(dateref)
    psql.charge_from_BDD()
    ###
    ### fin chargement table
    ###

    rupture_numdep = Rupture('000')
    rupture_datecro = Rupture(date.today())
    rupture_numope  = Rupture('00000')

    #module MA82323
    #calcul journee complementaire
    dfjc = Dfjc()
    _dateDeComptabilisation = dfjc.get_datecompabilisation(dateref)
    # fin module MA82323
    pseudo = StockageEcriture()
    lesCros = StockageCro()

    cur.execute("SELECT * FROM CRO_C23121A ORDER BY  numdep ,dcroope, ncrooper, ccrolop;")
    for record in cur:
        #print(record)
        croatraiter = Cro(record)
        if rupture_numdep.testeBool(croatraiter.numdep):
            rupture_datecro.force_rupture()
            rupture_numope.force_rupture()
        if rupture_datecro.testeBool(croatraiter.DCROOPE):
            rupture_numope.force_rupture()
            #recalcul date JC
        if  rupture_numope.testeBool(croatraiter.NCROOPER):
            #controle ecriture et vidage
            print("------- traitemen de {}".format(len(lesCros.stockage)))
            for item in lesCros.stockage:
                item.infocpte()
                for ps in item.ecritures:
                    print(ps)
                    print(ps,file=fs)
            lesCros.reset()
            print("--------------------------------------------------------------------------------")
        croatraiter.ajusteCro_ano()
        compta = schema.recherche_operation(croatraiter.cle_pcta())
        clefinale= compta[0].CCROLOP+compta[0].CTCLI+compta[0].CCROANOC
        cleycte =croatraiter.cle_ycte()
        croatraiter.add_infos(len(compta),clefinale)
        if croatraiter.compte_clientBOOL():  #
          codeJC_YCTE = ycte.get_cyctcjc(cleycte)
        else:
          codeJC_YCTE ='O'
        codeJC_BOPE  = bope.get_cbopcjc(compta[0].CCROLOP,cleycte)
        if croatraiter.isdanslaJC():
              _dateDeComptabilisation = dfjc.get_datecompabilisation(dateref)

        cpligne =0
        for ligne in compta:
            cpligne+=1
            if cpligne != ligne.get_nctalgns():
                raise RuntimeError("Numero de ligne schema incoherent")


            ecr = PseudoEcriture()
            #ajuste le flag cro journee complementaire
            ecr.set_DHECCOMP(_dateDeComptabilisation)
            ecr.set_NUMDEP(croatraiter.numdep)
            ecr.set_NCROOPER(croatraiter.NCROOPER)
            ecr.set_ccrolop(croatraiter.CCROLOP)
            ecr.set_NHECLGSC(str(cpligne).zfill(2))
            ecr.set_poste(croatraiter.POSTE_)
            ecr.set_cleycte(cleycte)
            _spsencpt1 = ligne.get_cctamafi()
            _spsencpt2 = ligne.get_lctataru()
            ecr.set_CPSECOMA(' ')
            ecr.set_DCROOPE(croatraiter.DCROOPE)
            ecr.set_CPSECCLI('N')  # indicateur de compte client o/n
            ecr.set_CPSEIMPE('O')
            ecr.set_CHECSNS(ligne.cctasnse)

            ecr.set_DCROVAL(croatraiter.DCROVAL)
            ecr.set_MCROOPE(croatraiter.MCROOPE)
            if _spsencpt1 == 'CRO' and _spsencpt2 == 'SCPT1002':
                ecr.set_SPSENCPT(croatraiter.get_compte())
                ecr.set_CPSECCLI('O')
                #print(ecr.SPSENCPT)
            elif _spsencpt1 =='CTABPARR':
                contrepartie = parr.recherche(croatraiter.CBOPCONT, _spsencpt2)
                _complement = croatraiter.get_ncroarr() + '0' + contrepartie
                ecr.set_SPSENCPT(_complement)
                ecr.set_CPSECOMA(contrepartie[0])
                #controle de la contrepartie
                if  cint.iscleexisteBool(contrepartie) and cint.get_CCINMAJB(contrepartie) =='N':
                   ecr.set_CPSEIMPE('O')
                if   contrepartie[0] =='E'  and  not cint.iscleexisteBool(contrepartie):
                   ecr.set_CPSEIMPE('N')
            elif _spsencpt1 =='CTABYCTE':
                contrepartie = ycte.get_syctcass(cleycte)
                _complement = croatraiter.get_ncroarr() + '0' + contrepartie
                ecr.set_SPSENCPT(_complement)
                ecr.set_CPSECOMA(contrepartie[0])
            else:
                raise RuntimeError("TODO:{}".format(_spsencpt1))
            #pseudo.add(ecr)
            ecr.set_ccrosche(croatraiter.ccrosche)
            (_checnot, _czvsnot,_czvstnot)= ligne.analyseCCTAREFN()
            ecr.set_checnot(_checnot)
            if ecr.DHECCOMP < dateref:
               ecr.set_checexo('O')
            else:
               ecr.set_checexo('N')
            ### gestion des libelles
            if  ligne.isLibelleStandardBool():
                # libelle issu du module M442323
                ecr.set_lhecpart(croatraiter.get_lzvsecr1())
                ecr.set_lhecsep(' ')
                ecr.set_scro1np1('              ')
                ecr.set_lheclibe('tout_espace')
                ecr.set_lheclib2('tout_espace')
            else:
                croatraiter.permuteZonelibelle()
                clepsql = ligne.get_clePsql()
                if clepsql == "917990999901":
                    print('eg')
                #recuperer la ligne psql
                libellepsql = psql.cherche(clepsql)
                tableauVariable = libellepsql.variables
                dictpsql = croatraiter.get_valeurPsql(tableauVariable)
                les_libelles = libellepsql.remplace(dictpsql)
                ecr.set_lhecpart(les_libelles[0])
                ecr.set_lhecsep(les_libelles[1][0:1])
                ecr.set_scro1np1(les_libelles[1][1:])
                ecr.set_lheclibe(les_libelles[2])
                if ecr.lheclibe.find('6/16 REGIE') >0:
                     print('rt')
                ecr.set_lheclib2(les_libelles[3])
            if croatraiter.compte_clientBOOL():   #M472323  ### traitement ecr client
                ecr.set_LHECSPE1('tout_espace')
                ecr.set_LHECSPE2('tout_espace')
                if croatraiter.isPrelVirBool():
                    ecr.set_DCROREF(croatraiter.dbrmrecp)
                    ecr.set_LHECSPE1(croatraiter.nbrmordr)
            croatraiter.add_ecr(ecr)
            #print("ecriture num:{}".format(cpligne))
            #print(ecr)
        lesCros.add(croatraiter)
    print("------- traitemen de {}".format(len(lesCros.stockage)))
    for item in lesCros.stockage:
        item.infocpte()
        for ps in item.ecritures:
                    print(ps)
                    print(ps,file=fs)
    lesCros.reset()
    print("--------------------------------------------------------------------------------")
    fs.close()
main()
