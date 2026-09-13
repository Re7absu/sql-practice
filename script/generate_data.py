import csv
import random
from datetime import datetime, timedelta

with open("sensor_readings.csv", "w", newline="") as file:
    writer = csv.writer(file)

    start_time = datetime(2026, 1, 1)

    for i in range(200000):
        camera_id = random.randint(1, 20)
        temperature = round(random.uniform(20, 40), 2)
        humidity = round(random.uniform(30, 80), 2)
        recorded_at = start_time + timedelta(minutes=i)

        writer.writerow([
            camera_id,
            temperature,
            humidity,
            recorded_at
        ])

