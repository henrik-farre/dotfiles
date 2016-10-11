#!/usr/bin/python
# This script was hacked to fix some databases that were declared as Latin-1
# [I mean MySQL is a Swedish company, but Latin-1-Swedish as a default?!?!]
# and contained UTF-8. MySQL "helpfully" converted some -- and not all, go figure
# of the strings to Latin-1. Very big mess indeed.
# This situation may happen to other people, so I decided to make it available.
# GPL, free of charge, use at your own risk -- I have one [happy] witness who says
# Thank You dda!
# So if it doesn't fix your dbs, or breaks them, sorry! -- This script worked as intended!
# 2005/2/12 - 03:10:00
# dda http://sungnyemun.org/weblog2/

# This is a new incarnation of the script, destined to fix stuff which was
# encoded twice as UTF-8 (double UTF-8). Thanks dda_, sbp, bonsaikitten, and
# Blackb|rd. Unfortunately it doesn't work (if this is indeed the lastest version)
# I just does nothing. Don't use it unless you're all backed up and ready to
# go through hell. Consider yourself warned. 
# 2006/7/12 bunny http://climbtothestars.org

import MySQLdb, codecs, sys

def normalise(raw):
   """Normalise utf-8, double-utf-8, or iso-8859-1 to utf-8. Cf.http://mzz.mine.nu/m/unithing.py.txt

   >>> normalise('\x97')
   '\xc2\x97'
   >>> normalise('\xe2\x80\xbd')
   '\xe2\x80\xbd'
   >>> normalise('\xc3\xa2\xc2\x80\xc2\xbd')
   '\xe2\x80\xbd'

   """
   try: uni = raw.decode('utf-8')
   except UnicodeDecodeError:
      uni = raw.decode('iso-8859-1')
      return uni.encode('utf-8')

   try:
      raw = uni.encode('iso-8859-1')
      uni.decode('utf-8')
   except UnicodeEncodeError: return raw
   return raw

host='localhost'
user=''
pwd=''
errorDB = {}
def connect2db(host, user, passwd, db):
  zeDB=''
  try:
    zeDB = MySQLdb.connect(host, user, passwd,db)
    return zeDB
  except: 
    return "N/A"
if __name__ == '__main__':
  ATilde="\303\203"
  db=connect2db(host,user,pwd,'mysql')
  if  db=="N/A":
    print("What?!?!")
  else:   
    cursor=db.cursor()
    cursor.execute("SHOW DATABASES")
    result = cursor.fetchall()
    db.close()
    for myDBs in result:
      myDB=myDBs[0]
#      if myDB != "dspam" and myDB != "mysql" and myDB != "test" and myDB != "spip":
      if myDB == "mediawiki":
        print("Database: %s"%myDB)
        db=connect2db(host,user,pwd,myDB)
        cursor=db.cursor()
#        cursor.execute("ALTER DATABASE `%s` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci"%myDB)
        cursor.execute("SHOW TABLES")
        zeTables = cursor.fetchall()
        for myTables in zeTables:
          print(" * %s.%s"%(myDB,myTables[0]))
          cursor=db.cursor()
#          cursor.execute("ALTER TABLE `%s` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci"%(myTables[0]))
          cursor.execute("DESCRIBE %s.%s"%(myDB,myTables[0]))
          zeDesc = cursor.fetchall()
          zeDesc2 = {}
          k=0
          fieldNames={}
          name2Field={}
          for i in zeDesc:
            zeDesc2[k]=i[1]
            fieldNames[k]=i[0]
            name2Field[i[0]]=k
#            if i[1].find('varchar')>-1 or i[1].find('text')>-1  or i[1].find('enum')>-1:
#              cursor.execute("ALTER TABLE `%s` CHANGE `%s` `%s` %s CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL"%(myTables[0],i[0],i[0],i[1]))
            k+=1
          descLen=len(zeDesc2)
          cursor.execute("SELECT * FROM %s.%s"%(myDB,myTables[0]))
          zeLines = cursor.fetchall()
          for li in zeLines:
            for zeFieldNum in range(0,descLen):
              zeField=li[zeFieldNum]
              if zeField!=None and (zeDesc2[zeFieldNum].find('varchar')>-1 or zeDesc2[zeFieldNum].find('text')>-1):
                try:
                  print(" . Looking at zeField: %s ~ %s for: %s"%(fieldNames[zeFieldNum],zeDesc2[zeFieldNum], ATilde))
                  pos=zeField.find(ATilde)
                  if pos>-1:
                    print("   |__> We have a %s, normalizing zeField."%ATilde)
                    txt=normalise(zeField)
                    sql = "UPDATE %s.%s SET `%s` = %%s WHERE %s = %%s" % (myDB, myTables[0], fieldNames[zeFieldNum], fieldNames[0])
                    cursor.execute(sql, (txt, li[0]))
                except Exception, e:
                  print(e)
                  sys.exit()
