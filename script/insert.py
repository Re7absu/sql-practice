import csv
import psycopg
import time

start_time = time.time()

insert_list = []
with open("data/sensor_readings.csv","r") as file :
    reader = csv.reader(file)
    for row in reader :
        insert_list.append(row)


#-1-connect with db
conn = psycopg.connect(
    "dbname=test user=postgres password=Re7ab95 host=localhost port=5432"
)
#2- creat cursor : A tool used to execute SQL commands and retrieve results
cur = conn.cursor()

#3-to execute the commands
for row in insert_list:
    cur.execute(
        #her writte sql commend
        "INSERT INTO sensor_readings (camera_id,temperature,humidity,recorded_at)" 
        " VALUES(%s, %s,%s, %s)",
        (row[0], row[1], row[2], row[3])    
    )

# 4- to const commends
conn.commit()

end_time = time.time()
print(f"INSERT took {end_time - start_time:.2f} seconds")

# 5- to close 
conn.close()
cur.close()











    