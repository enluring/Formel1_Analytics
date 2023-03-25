--- CSV info: driverId,driverRef,number,code,forename,surname,dob,nationality,url
CREATE TABLE drivers (
    driverId SERIAL PRIMARY KEY,
    driverRef VARCHAR(20),
    number INTEGER,
    code VARCHAR(10),
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
    circuitId SERIAL PRIMARY KEY,
    circuitRef VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    country VARCHAR(255),
    lat numeric,
    lng numeric,
    altitude VARCHAR(5),
    url VARCHAR(255)
);


--- raceId,year,round,circuitId,name,date,time,url,fp1_date,fp1_time,fp2_date,fp2_time,fp3_date,fp3_time,quali_date,quali_time,sprint_date,sprint_time
CREATE TABLE races (
    raceId SERIAL PRIMARY KEY,
    year numeric,
    round numeric,
    circuitId INTEGER REFERENCES circuits (circuitId),
    name VARCHAR(100),
    date date,
    time time without time zone,
    url VARCHAR(255),
    fp1_date date,
    fp1_time time without time zone,
    fp2_date date,
    fp2_time time without time zone,
    fp3_date date,
    fp3_time time without time zone,
    quali_date date,
    quali_time time without time zone,
    sprint_date date,
    sprint_time time without time zone
);

--- raceId,driverId,lap,position,time,milliseconds
CREATE TABLE lap_times (
    raceid INTEGER REFERENCES races (raceid),
    driverid INTEGER REFERENCES drivers (driverId),
    lap INTEGER,
    position INTEGER,
    time VARCHAR(20),
    milliseconds VARCHAR(20)
);


---- driverStandingsId,raceId,driverId,points,position,positionText,wins
CREATE TABLE lap_times (
    driverStandingsId INTEGER,
    raceId INTEGER REFERENCES races (raceId),
    driverId INTEGER REFERENCES drivers (driverId),
    points INTEGER,
    position INTEGER,
    positionText VARCHAR(20),
    wins INTEGER
);
