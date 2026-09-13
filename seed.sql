COPY buildings
FROM 'C:/Users/re7ab/Downloads/database/data/buildings.csv'
WITH (FORMAT csv, HEADER false);

COPY alerts
FROM 'C:/Users/re7ab/Downloads/database/data/alerts.csv'
WITH (FORMAT csv, HEADER false);

COPY cameras
FROM 'C:/Users/re7ab/Downloads/database/data/cameras.csv'
WITH (FORMAT csv, HEADER false);

COPY sensor_readings
FROM 'C:/Users/re7ab/Downloads/database/data/sensor_readings.csv'
WITH (FORMAT csv, HEADER false);

COPY users
FROM 'C:/Users/re7ab/Downloads/database/data/users.csv'
WITH (FORMAT csv, HEADER false);

