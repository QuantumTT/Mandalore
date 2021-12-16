# Builds the Mandalore db if it doesn't exist

from getpass import getpass
from mysql.connector import connect, Error

code_file = open('Mandalore_source_code.txt', 'r')
db_build_query = ''
for line in code_file:
    db_build_query += line

try:
    with connect(
        host = 'localhost',
        port = '3306',
        user = 'root',
        password = 'u44bKWkJeEs%3S8b'
    ) as connection:
        with connection.cursor() as cursor:
            iterator = cursor.execute(db_build_query, params=None, multi=True)
            for line in iterator:
                pass
            connection.commit()
            cursor.execute("show databases")
            results = cursor.fetchall()
            for row in results:
                print(row)
            print('Successfully created schema "mandalore"')

except Error as e:
    print(e)


# Close all the files
code_file.close()