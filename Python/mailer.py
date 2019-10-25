# coding: utf-8
import sys
import smtplib
from email.mime.text import MIMEText

fic = sys.argv[1]
with open(fic, 'r') as file:
    lignes = file.readlines()
lignes = lignes[1:]



server = smtplib.SMTP('SSL0.OVH.NET', 587)
server.starttls()
server.login("XXXXXXXXXXX","YYYYYYY")

#lignes = [f"'';'';'';german.eric@gmail.com;n"]
for ligne in lignes:
    ligne= ligne[:-1]
    tab= ligne.split(';')
    email= tab[1]
    msg = MIMEText(f'''     bonjour, \n
                   ''')
    msg['Subject']  =  "Rappel: demain samedi 26/10/2019 =>  9h-13h: Seminaire des animateurs locaux de la LaREM94"
    msg['From']  ='Support Enmarche94 <eric.german@enmarche94.fr>'
    msg['To']  = email
    server.sendmail("eric.german@enmarche94.fr", email, msg.as_string())
server.quit()