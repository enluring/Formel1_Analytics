-- DriverResults view
CREATE VIEW public."DriverResults" AS
SELECT results.raceid,
       results.driverid,
       results.grid,
       results.position,
       results.points,
       drivers.number,
       drivers.code,
       drivers.forename,
       drivers.surname
FROM results
JOIN drivers ON drivers.driverid = results.driverid;

-- DriverStandings View
CREATE VIEW public."DriverStandings" AS
SELECT driver_standings.driverid,
       driver_standings.raceid,
       driver_standings.points,
       driver_standings.position,
       driver_standings.wins,
       drivers.number,
       drivers.code,
       drivers.forename,
       drivers.surname
FROM driver_standings
JOIN drivers ON drivers.driverid = driver_standings.driverid;

-- DriverStandings View
CREATE VIEW public."ConstructorResults" AS
SELECT results.raceid,
       results.constructorId,
       results.position,
       results.points,
       constructors.constructorRef,
       constructors.name,
       constructors.nationality
FROM results
JOIN constructors ON constructors.constructorId = results.constructorId;

CREATE VIEW public."RaceCircuits" AS
SELECT races.year,
    races.round,
    races.name,
    races.date,
    circuits.country,
    circuits.location
    circuits.lat,
    circuits.lng,
    races.url
FROM races
JOIN circuits ON circuits.circuitid = races.circuitid
