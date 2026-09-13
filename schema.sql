CREATE TABLE buildings (
    id SERIAL PRIMARY KEY , 
    name VARCHAR(50) NOT NULL , 
    location VARCHAR(50) NOT NULL 
);

CREATE TABLE cameras (
    id SERIAL PRIMARY KEY , 
    building_id INT NOT NULL, 
    name VARCHAR(50) NOT NULL , 
    location VARCHAR(50) NOT NULL , 
    FOREIGN KEY (building_id) 
        REFERENCES buildings(id)
);

CREATE TABLE sensor_readings (
    id SERIAL PRIMARY KEY , 
    camera_id INT NOT NULL, 
    temperature DECIMAL,
    humidity DECIMAL,
    recorded_at TIMESTAMP NOT NULL,

    FOREIGN KEY (camera_id)
        REFERENCES cameras(id)
);

CREATE TABLE users ( 
    id SERIAL PRIMARY KEY , 
    name VARCHAR(50) NOT NULL , 
    email VARCHAR(150)
    
); 

CREATE TABLE alerts (
    id SERIAL PRIMARY KEY, 
    camera_id INT NOT NULL, 
    message VARCHAR(50) NOT NULL , 
    type_message VARCHAR(50) NOT NULL, 
    user_id INT, 
    message_at TIMESTAMP NOT NULL , 

    FOREIGN KEY(camera_id) REFERENCES cameras(id)
    FOREIGN KEY(user_id) REFERENCES users(id)
);

