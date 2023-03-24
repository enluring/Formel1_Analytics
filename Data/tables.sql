--- CSV info: driverId,driverRef,number,code,forename,surname,dob,nationality,url
CREATE TABLE drivers (
    driverId SERIAL PRIMARY KEY,
    driverRef VARCHAR(20),
    number INTEGER,
    code VARCHAR(10)
    forename VARCHAR(50),
    surname VARCHAR(50),
    dob DATE,
    nationality VARCHAR(50),
    url VARCHAR(255)

);

--- constructorId,constructorRef,name,nationality,url
CREATE TABLE constructors (
    constructorId SERIAL PRIMARY KEY,
    constructorRef VARCHAR(30),
    name VARCHAR(100) UNIQUE,
    nationality VARCHAR(50),
    url VARCHAR(255)
); 



-- Create the circuits table circuitId,circuitRef,name,location,country,lat,lng,alt,url
CREATE TABLE circuits (
    circuit_id SERIAL PRIMARY KEY,
    circuit_ref VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    country VARCHAR(255),
    geolocation POINT,
    altitude INT,
    url VARCHAR(255)
);


--- raceId,year,round,circuitId,name,date,time,url,fp1_date,fp1_time,fp2_date,fp2_time,fp3_date,fp3_time,quali_date,quali_time,sprint_date,sprint_time
CREATE TABLE races (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    date DATE,
    circuit INTEGER REFERENCES circuits (circuit_id)
);

CREATE TABLE lap_times (
    race_id INTEGER REFERENCES races (id),
    driver_id INTEGER REFERENCES drivers (id),
    lap INTEGER,
    time VARCHAR(20),
    session_type VARCHAR(10)
);

CREATE TABLE results (
    race_id INTEGER REFERENCES races (id),
    driver_id INTEGER REFERENCES drivers (id),
    team_id INTEGER REFERENCES teams (id),
    start_grid INTEGER,
    position INTEGER,
    points FLOAT,
    laps INTEGER,
    time VARCHAR(20),
    fastest_lap INTEGER,
    fastest_lap_time VARCHAR(20)
);

