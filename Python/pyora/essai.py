import re
subre_posi = r'([^,])( POSITION)([^_])'

ligne =   'CREATE OR REPLACE FORCE VIEW "SAFIRA_PRODUCTION"."V_PANDA_FK_NOT_INDEXED" ("NOM_CONTRAINTE", "NOM_TABLE", "NOM_COLONNE", "POSITION", "NB_LIGNES") AS '

ligne = ligne.replace('"','')
ligne =  re.sub(subre_posi,r'[^,]AS POSITION[^_]',ligne,flags= re.IGNORECASE)

print(ligne)
ligne = 'acc.position                  POSITION, tb.num_rows                   NB_LIGNES FROM user_cons_columns acc, user_constraints ac, '
ligne = ligne.replace('"','')
ligne =  re.sub(subre_posi,r'\1AS \2\3',ligne,flags= re.IGNORECASE)
print(ligne)
