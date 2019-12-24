import cx_Oracle

con = cx_Oracle.connect('safi/safi@localhost/safi')
#print(con.version)
sql_r = "select * from assessment"
cur = con.cursor()
#for row in cur.execute(sql_r):
#    print(row)
sql_2 = "select table_name, search_condition from user_constraints where constraint_type='C'"
for row in cur.execute(sql_2):
    print(row)
sql_3 =  "SELECT SEQUENCE_NAME, INCREMENT_BY, CYCLE_FLAG, LAST_NUMBER FROM user_sequences"
for row in cur.execute(sql_3):
    print(row) 
con.close()