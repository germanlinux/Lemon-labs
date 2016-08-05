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
    cp927 =0
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
    #WHERE ccrolop = '923'
    #where numdep = '075'
    bug_sauveccrolop = '0000'
    #cur.execute("SELECT * FROM CRO_C23121A  ORDER BY  numdep ,dcroope, ncrooper, ccrolop;")
    cur.execute("SELECT * FROM CRO_C23121Adep  ORDER BY id; ")

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

            if croatraiter.MCROOPE=='00000003665764{' and croatraiter.CCROLOP == '927':
                 print('eg')
            ecr = PseudoEcriture()
            #ajuste le flag cro journee complementaire
            ecr.set_DHECCOMP(_dateDeComptabilisation)
            ecr.set_NUMDEP(croatraiter.numdep)
            ecr.set_NCROOPER(croatraiter.NCROOPER)
            ecr.set_ccrolop(croatraiter.CCROLOP)
            ecr.set_NHECLGSC(str(cpligne).zfill(2))
            ecr.set_poste(croatraiter.POSTE_)
            # correction bug crolop
            # correction poste 1753
            if ecr.NUMDEP =='175' and ecr.poste_ =='300':
                 ecr.set_poste('330')
            #correction ACSIA
            if ecr.NUMDEP =='375' and ecr.poste_ =='600':
                 ecr.set_poste('660')
            #if ecr.NUMDEP =='051' and croatraiter.CCROLOP =='912':
            #     bug_sauveccrolop ='0000'
            if ecr.NUMDEP =='051' and croatraiter.CCROLOP =='938':
                 bug_sauveccrolop ='0000'
            #fin ajustment poste
            ecr.set_cleycte(cleycte)
            _spsencpt1 = ligne.get_cctamafi()
            _spsencpt2 = ligne.get_lctataru()
            ecr.set_CPSECOMA(' ')
            ecr.set_DCROOPE(croatraiter.DCROOPE)
            ecr.set_CPSECCLI('N')  # indicateur de compte client o/n
            ecr.set_CPSEIMPE('O')
            ecr.set_CHECSNS(ligne.cctasnse)
            ecr.set_lhecspe1('')
            ecr.set_lhecspe2('')
            ecr.set_DCROVAL(croatraiter.DCROVAL)
            ecr.set_MCROOPE(croatraiter.MCROOPE)
            if _spsencpt1 == 'CRO' and _spsencpt2 == 'SCPT1002':
                ecr.set_SPSENCPT(croatraiter.get_compte())
                ecr.set_CPSECCLI('O')
                if croatraiter.typlibcr =='VP' and croatraiter.nbrmordr !='000000':
                     ecr.set_lhecspe2(croatraiter.nbrmordr)
                #print(ecr.SPSENCPT)
            elif _spsencpt1 =='CTABPARR':
                contrepartie = parr.recherche(croatraiter.CBOPCONT, _spsencpt2)
                _complement = croatraiter.get_ncroarr() + '0' + contrepartie
                ecr.set_SPSENCPT(_complement)
                ecr.set_CPSECOMA(contrepartie[0])
                if _spsencpt2 =='SPARCPAR':
                   (_piece1, _piece2) =parr.get_lhecspe(croatraiter.CBOPCONT, _spsencpt2)
                   ecr.set_lhecspe2(_piece2)
                   if contrepartie == 'E39231   ' and croatraiter.cboprgpt == '03':
                       ecr.set_lhecspe2(croatraiter.ncroposd[0:4])
                   if (contrepartie == 'E39230   '  or contrepartie == 'E39231   ' ) and croatraiter.cboprgpt == '16':
                       ecr.set_lhecspe2(croatraiter.ncroposd[0:4])
                   if ecr.lhecspe2[0:4] == '1753':
                       ecr.set_lhecspe2('0753')
                   if ecr.lhecspe2[0:4] == '2752':
                       ecr.set_lhecspe2('0752')
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
             # pour mise au point
            if croatraiter.CCROLOP=='706':
                 print('eg')
            if croatraiter.MCROOPE=='00000003665764{':
                 print('eg')
            ecr.set_checerel('N')
            if  croatraiter.CCROLOP == '362'  or   croatraiter.CCROLOP == '370':
                ecr.set_checerel('O')
            ecr.set_ccrosche(croatraiter.ccrosche)
            (_checnot, _czvsnot,_czvstnot)= ligne.analyseCCTAREFN()
            ecr.set_checnot(_checnot)
            if ecr.DHECCOMP < dateref:
               ecr.set_checexo('O')
            else:
               ecr.set_checexo('N')
            #notage et denotage
            if ligne.isgestionparPSQL()== False:
            #TODO controle coherence notage pcta et cint (CZVSNOT)
                if _checnot == 'D':  #c est un denotage
                    ecr.set_ccroden(croatraiter.CCRODENO)
                    ecr.set_DCRODEN(croatraiter.DCRODENO)
                    ecr.set_ncroden(croatraiter.NCRODENO)
                    if ecr.get_dheccomp_str() != croatraiter.DCRODENO.strftime("%Y%m%d"):
                       bug_sauveccrolop = croatraiter.CCRODENO
                    else:
                       bug_sauveccrolop ='0000'
                    if  len(compta) == 2 and cpligne ==2 and croatraiter.CCROLOP =='927':
                       bug_sauveccrolop =croatraiter.CCRODENO
                       cp927+=1
                if _checnot =='N': #
                    ecr.set_ccroden(croatraiter.CBOPNOTA)
                    #ecr.set_DCRODEN(croatraiter.DCROOPE)
                    ecr.set_DCRODEN(croatraiter.dcrodene)
                    if croatraiter.dcrodene =='0'*8:
                         ecr.set_DCRODEN(croatraiter.DCROOPE)
                    ecr.set_ncroden('00000')
                    bug_sauveccrolop = croatraiter.CBOPNOTA.rjust(4,'0')
                    if croatraiter.isCB() and len(compta) == 2 and cpligne ==2:
                       ecr.set_ncroden(croatraiter.hfacrdab)
                    if croatraiter.NCROOPER != '00000'  and len(compta) == 2 and cpligne ==2 and croatraiter.CCROLOP =='265':
                       ecr.set_ncroden(croatraiter.NCROOPER)
                    if cpligne ==1 and ecr.ccroden =='0831':
                       bug_sauveccrolop ='0000'
                if _checnot == ' ':
                   ecr.set_ccroden(bug_sauveccrolop) #### reproduction du bug originel
                if ecr.isEcrClient():  #ecriture client
                    #ecr.set_ncroden('00000')
                    ecr.set_ccroden('0')
                    ecr.set_ccroden (bug_sauveccrolop) #### reproduction du bug originel
                    bug_sauveccrolop ='0000'
                    #ecr.set_DCRODEN(None)
                if croatraiter.isCB() and ligne.CCTAMAFI =='CTABYCTE':
                    ecr.set_ncroden(croatraiter.hfacrdab)
                if  len(compta) == 3 and cpligne ==3 and croatraiter.CCROLOP =='269':
                       bug_sauveccrolop ='0000'
                       ecr.set_ccroden (bug_sauveccrolop)
                if  len(compta) == 3 and cpligne ==3 and croatraiter.CCROLOP =='530':
                       bug_sauveccrolop ='0000'
                       ecr.set_ccroden (bug_sauveccrolop)
                if  len(compta) == 3 and cpligne ==3 and croatraiter.CCROLOP =='484':
                       bug_sauveccrolop ='0000'
                       ecr.set_ccroden (bug_sauveccrolop)
                if  len(compta) == 3 and cpligne ==3 and croatraiter.CCROLOP =='912':
                       bug_sauveccrolop ='0000'
                       ecr.set_ccroden (bug_sauveccrolop)
                if  len(compta) == 2 and cpligne ==2 and croatraiter.CCROLOP =='912':
                       bug_sauveccrolop ='0000'
                       ecr.set_ccroden (bug_sauveccrolop)

                if  len(compta) == 2 and cpligne ==2 and croatraiter.CCROLOP =='519':
                       bug_sauveccrolop ='0000'
                       ecr.set_ccroden (bug_sauveccrolop)

            else:
                if ecr.isEcrClient():  #ecriture client
                    #ecr.set_ncroden('00000')
                    ecr.set_ccroden('0')
                    ecr.set_ccroden (bug_sauveccrolop) #### reproduction du bug originel
                    bug_sauveccrolop ='0000'
                    #ecr.set_DCRODEN(None)
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
    cur.close()
    conn.close()
    print(cp927)
main()
