-- DriverStandings View - gets data from driverstandings and gets driverdetails from drivers table
CREATE VIEW public."DriverStandings" AS
SELECT driver_standings.driverid,
    driver_standings.raceid,
    driver_standings.points,
    driver_standings."position",
    driver_standings.wins,
    drivers.number,
    drivers.code,
    (drivers.forename::text || ' '::text) || drivers.surname::text AS name,
    races.year,
    races.round
   FROM driver_standings
     JOIN drivers ON drivers.driverid = driver_standings.driverid
     JOIN races ON drivers.raceid = races.raceid;

--- DriverResults - select data from results table and then get ekstra info from driver, constructors and status table
 CREATE VIEW public."DriverResults" AS
 SELECT results.raceid,
    results.driverid,
    results.constructorid,
    results.grid,
    results."position",
    results.points,
    results.laps,
    results.statusid,
    drivers.number,
    drivers.code,
    drivers.url,
    drivers.dob,
    (drivers.forename::text || ' '::text) || drivers.surname::text AS name,
    constructors.name AS team,
    status.status,
    races.year,
    races.round
   FROM results
     JOIN drivers ON drivers.driverid = results.driverid
     JOIN constructors ON results.constructorid = constructors.constructorid
     JOIN status ON results.statusid = status.statusid
     JOIN races ON results.raceid = races.raceid;


---- ConstructorResults - Gets its bases out of results, but add information about the teams
CREATE VIEW public."ConstructorResults" AS
SELECT results.raceid,
    results.constructorid,
    results."position",
    results.points,
    constructors.constructorref,
    constructors.name AS team,
    constructors.nationality
   FROM results
     JOIN constructors ON constructors.constructorid = results.constructorid;

-- Racecirucuits - Combining the races pr year with all possible asic circuits info
CREATE VIEW public."RaceCircuits" AS
SELECT races.year,
    races.round,
    races.name,
    races.date,
    races.raceid,
    circuits.country,
    circuits.location
    circuits.lat,
    circuits.lng,
    races.url
FROM races
JOIN circuits ON circuits.circuitid = races.circuitid

---- 
CREATE VIEW public."LapTimes_LastRace" AS
 SELECT lap_times.raceid,
    lap_times.driverid,
    (drivers.forename::text || ' '::text) || drivers.surname::text AS name,
    lap_times.lap,
    lap_times."position",
    lap_times."time",
    lap_times.milliseconds
   FROM lap_times
     JOIN drivers ON drivers.driverid = lap_times.driverid
   WHERE lap_times.raceid = (( SELECT max(results.raceid) AS max FROM results));