import cx_Oracle
import psycopg2 as Pg


con_o = cx_Oracle.connect('safi/safi@localhost/safi')
con_p = Pg.connect( host='localhost', user='postgres', password='german', dbname='safi')
#print(con_p.version)
sql_r = "select * from assessment"
curp = con_p.cursor()
curp_i = con_p.cursor()
curo = con_o.cursor()
#curp.execute(sql_r)
'''
for row in curp.fetchall():
    print(row)
    raw = ('2',) + row[1:]
    print(raw)
    sql_ins = "insert into  assessment VALUES ( %s, %s, %s, %s ,%s , %s)"
    print(sql_ins)
    curp_i.execute(sql_ins,raw)
'''
#sql_2 = "select table_name, schallearch_condition from user_constraints where constraint_type='C'"
rowes= []
for row in curo.execute(sql_r):
    print(row)
    longueur = len(row)
    sql_ins = "insert into  assessment VALUES ("
    for i in range(longueur):
        sql_ins+=' %s,'
    sql_ins = sql_ins[:-1] + ')' 
    #print(sql_ins)
    rowes.append(row)
curp_i.executemany(sql_ins,rowes)
    

#sql_3 =  "SELECT SEQUENCE_NAME, INCREMENT_BY, CYCLE_FLAG, LAST_NUMBER FROM user_sequences"
#for row in cur.execute(sql_3):
#    print(row)
con_p.commit() 
con_p.close()
con_o.close()