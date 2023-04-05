CREATE TABLE drivers (
    driverId INTEGER PRIMARY KEY,
    driverRef VARCHAR(20),
    number INTEGER,
    code VARCHAR(10),
    forename VARCHAR(255),
    surname VARCHAR(255),
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
    circuitId INTEGER PRIMARY KEY,
    circuitRef VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    country VARCHAR(255),
    lat numeric,
    lng numeric,
    alt INTEGER,
    url VARCHAR(255)
);


---- year,url
CREATE TABLE seasons (
    year INTEGER PRIMARY KEY,
    url VARCHAR(255)
);

--- raceId,year,round,circuitId,name,date,time,url,fp1_date,fp1_time,fp2_date,fp2_time,fp3_date,fp3_time,quali_date,quali_time,sprint_date,sprint_time
CREATE TABLE races (
    raceId INTEGER PRIMARY KEY,
    year INTEGER REFERENCES seasons (year),
    round INTEGER,
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

---- constructorStandingsId,raceId,constructorId,points,position,positionText,wins
CREATE TABLE constructor_standings (
    constructorStandingsId INTEGER PRIMARY KEY,
    raceId INTEGER REFERENCES races (raceId),
    constructorId INTEGER REFERENCES constructors (constructorId),
    points numeric,
    position INTEGER,
    positionText VARCHAR(255),
    wins INTEGER
);


---- driverStandingsId,raceId,driverId,points,position,positionText,wins
CREATE TABLE driver_standings (
    driverStandingsId INTEGER PRIMARY KEY,
    raceId INTEGER REFERENCES races (raceId),
    driverId INTEGER REFERENCES drivers (driverId),
    points numeric,
    position INTEGER,
    positionText VARCHAR(20),
    wins INTEGER
);


--- raceId,driverId,lap,position,time,milliseconds
CREATE TABLE lap_times (
    raceId INTEGER REFERENCES races (raceid),
    driverId INTEGER REFERENCES drivers (driverId),
    lap INTEGER,
    position INTEGER,
    time VARCHAR(20),
    milliseconds INTEGER
);

--- raceId,driverId,stop,lap,time,duration,milliseconds
CREATE TABLE pit_stops (
    raceId INTEGER REFERENCES races (raceid),
    driverId INTEGER REFERENCES drivers (driverId),
    stop INTEGER,
    lap INTEGER,
    time VARCHAR(20),
    duration VARCHAR(20),
    milliseconds INTEGER
);

--- qualifyId,raceId,driverId,constructorId,number,position,q1,q2,q3
CREATE TABLE qualifying (
    qualifyId INTEGER PRIMARY KEY,
    raceId INTEGER REFERENCES races (raceId),
    driverId INTEGER REFERENCES drivers (driverId),
    constructorId INTEGER REFERENCES constructors (constructorId),
    number INTEGER,
    position INTEGER,
    q1 VARCHAR(255),
    q2 VARCHAR(255),
    q3 VARCHAR(255)
);
--- resultId,raceId,driverId,constructorId,number,grid,position,positionText,positionOrder,points,laps,time,milliseconds,fastestLap,rank,fastestLapTime,fastestLapSpeed,statusId
CREATE TABLE results (
    resultId INTEGER PRIMARY KEY,
    raceId INTEGER REFERENCES races (raceid),
    driverId INTEGER REFERENCES drivers (driverId),
    constructorId INTEGER REFERENCES constructors (constructorId),
    number INTEGER,
    grid INTEGER,
    position INTEGER,
    positionText VARCHAR(255),
    positionOrder INTEGER,
    points float,
    laps INTEGER,
    time VARCHAR(255),
    milliseconds INTEGER,
    fastestLap INTEGER,
    rank INTEGER,
    fastestLapTime VARCHAR(20),
    fastestLapSpeed VARCHAR(20),
    statusId INTEGER
);


-- resultId,raceId,driverId,constructorId,number,grid,position,positionText,positionOrder,points,laps,time,milliseconds,fastestLap,fastestLapTime,statusId
CREATE TABLE sprint_results (
    resultId INTEGER PRIMARY KEY,
    raceId INTEGER REFERENCES races (raceid),
    driverId INTEGER REFERENCES drivers (driverId),
    constructorId INTEGER REFERENCES constructors (constructorId),
    number INTEGER,
    grid INTEGER,
    position INTEGER,
    positionText VARCHAR(10),
    positionOrder INTEGER,
    points float,
    laps INTEGER,
    time VARCHAR(20),
    milliseconds INTEGER,
    fastestLap INTEGER,
    fastestLapTime VARCHAR(20),
    statusId INTEGER
);


---- statusId,status
CREATE TABLE status (
    statusId INTEGER PRIMARY KEY,
    status VARCHAR(50)
);

---- constructorResultsId,raceId,constructorId,points,status
CREATE TABLE constructor_results (
    constructorResultsId INTEGER PRIMARY KEY,
    raceId INTEGER REFERENCES races (raceId),
    constructorId INTEGER REFERENCES constructors (constructorId),
    points numeric,
    position numeric,
    status VARCHAR(50)
);
