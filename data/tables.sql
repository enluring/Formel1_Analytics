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

---- driverStandingsId,raceId,driverId,points,position,positionText,wins
CREATE TABLE driver_standings (
    driverStandingsId INTEGER,
    raceId INTEGER REFERENCES races (raceId),
    driverId INTEGER REFERENCES drivers (driverId),
    points INTEGER,
    position numeric,
    positionText VARCHAR(20),
    wins INTEGER
);


--- constructorId,constructorRef,name,nationality,url
CREATE TABLE constructors (
    constructorId SERIAL PRIMARY KEY,
    constructorRef VARCHAR(30),
    name VARCHAR(100) UNIQUE,
    nationality VARCHAR(50),
    url VARCHAR(255)
); 

---- constructorResultsId,raceId,constructorId,points,status
CREATE TABLE constructor_results (
    constructorResultsId INTEGER,
    raceId INTEGER REFERENCES races (raceId),
    constructorId INTEGER REFERENCES constructors (constructorId),
    points numeric,
    position numeric,
    status VARCHAR(50)
);

---- constructorStandingsId,raceId,constructorId,points,position,positionText,wins
CREATE TABLE constructor_standings (
    constructorStandingsId INTEGER,
    raceId INTEGER REFERENCES races (raceId),
    constructorId INTEGER REFERENCES constructors (constructorId),
    points numeric,
    position numeric,
    positionText VARCHAR(10),
    wins numeric
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
    alt VARCHAR(5),
    url VARCHAR(255)
);


---- year,url
CREATE TABLE seasons (
    year VARCHAR(6) PRIMARY KEY,
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
    raceId INTEGER REFERENCES races (raceid),
    driverId INTEGER REFERENCES drivers (driverId),
    lap INTEGER,
    position INTEGER,
    time VARCHAR(20),
    milliseconds numeric
);

--- raceId,driverId,stop,lap,time,duration,milliseconds
CREATE TABLE pit_stops (
    raceId INTEGER REFERENCES races (raceid),
    driverId INTEGER REFERENCES drivers (driverId),
    stop INTEGER,
    lap INTEGER,
    time VARCHAR(20),
    duration VARCHAR(20),
    milliseconds numeric
);

--- resultId,raceId,driverId,constructorId,number,grid,position,positionText,positionOrder,points,laps,time,milliseconds,fastestLap,rank,fastestLapTime,fastestLapSpeed,statusId
CREATE TABLE results (
    resultId INTEGER PRIMARY KEY,
    raceId numeric,
    driverId INTEGER,
    constructorId INTEGER,
    number INTEGER,
    grid INTEGER,
    position INTEGER,
    positionText VARCHAR(10),
    positionOrder INTEGER,
    points numeric,
    laps INTEGER,
    time VARCHAR(20),
    milliseconds numeric,
    fastestLap INTEGER,
    rank numeric,
    fastestLapTime VARCHAR(20),
    fastestLapSpeed VARCHAR(20),
    statusId INTEGER
);


-- resultId,raceId,driverId,constructorId,number,grid,position,positionText,positionOrder,points,laps,time,milliseconds,fastestLap,fastestLapTime,statusId
CREATE TABLE sprint_results (
    resultId INTEGER PRIMARY KEY,
    raceId numeric,
    driverId INTEGER,
    constructorId INTEGER,
    number INTEGER,
    grid INTEGER,
    position INTEGER,
    positionText VARCHAR(10),
    positionOrder INTEGER,
    points numeric,
    laps INTEGER,
    time VARCHAR(20),
    milliseconds number,
    fastestLap INTEGER,
    fastestLapTime VARCHAR(20),
    statusId INTEGER
);


---- statusId,status
CREATE TABLE status (
    statusId INTEGER,
    status VARCHAR(50)
);
