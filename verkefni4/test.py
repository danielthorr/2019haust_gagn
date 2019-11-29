# -*- coding: UTF-8 -*-
# Just to be backwards compatible with python 2.7
from mysql.connector import MySQLConnection as mysqlconn
from mysql.connector import Error as mysqlerr
from mysql.connector import constants
from python_mysql_dbconfig import read_db_config

inp = ""

def connect():
  db_config = read_db_config()
  conn = None
  try:
    print("Connecting to MySQL database...")
    conn = mysqlconn(**db_config)
    conn.set_charset_collation("utf8")

    if conn.is_connected():
      print("Connection established.")
    else:
      print("Connection failed.")
  except mysqlerr as err:
    print(err)
  return conn
  

def main(conn):
  print("\n\nSelect which table you'd like to work with:\n\n\t1. Students\n\t2. Courses\n\t3. Schools")
  inp = input()
  if inp == "1":
    print("students")
    #students(conn)
  elif inp == "2":
    print("courses")
    #courses(conn)
  elif inp == "3":
    print("")
    #schools(conn)

  #args = [1, ""]
  #cursor = conn.cursor()
  #result = cursor.callproc('GetStudent', args)

  #print(result)

if __name__ == "__main__":
  conn = connect()
  while True:
    print("\nQuit? (y/n)")
    inp = input()
    if inp == "Y" or inp == "y":
      break
    main(conn)
  conn.close()