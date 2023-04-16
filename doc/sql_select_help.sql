--- This is select scripts that gets different data out, used in grafana

--- Gets a table with the standings after the last race from the view DriverStandings whith the filter (MAX(raceid))
SELECT "position", name, points, wins
	FROM public."DriverStandings"
	WHERE raceid = (SELECT MAX(raceid) FROM public."DriverStandings")
	ORDER BY "position" ASC;


--- Gets the result from the last race from the view DriverResults withthe filter MAX(raceid)
SELECT position, name, team, grid, laps, status, points
	FROM public."DriverResults"
	WHERE raceid = (SELECT MAX(raceid) FROM public."DriverResults")
	ORDER BY "position" ASC;


--- Gets the all rsults where an driver has position=1 (win) count the wins and groups it by driver and sets the winner on top
SELECT name, COUNT(*) AS wins
FROM public."DriverResults"
WHERE position = 1
GROUP BY name
ORDER BY wins DESC;


----  Same as over, but with poduium standings
SELECT name, COUNT(*) AS wins
FROM public."DriverResults"
WHERE position IN (1,2,3)
GROUP BY name
ORDER BY wins DESC;


---- select the last race number this year, in grafana select statics and select the status you want
SELECT raceid, round, year
	FROM public."DriverResults"
	where raceid = (SELECT MAX(raceid) FROM public."DriverResults")
	LIMIT 1;

---- Select the leader of this seson based on last race
SELECT raceid, name
	FROM public."DriverStandings"
	where raceid = (SELECT MAX(raceid) FROM public."DriverStandings")
	LIMIT 1;


---- Races Velger det siste racet hvor vi kan hente data
SELECT raceid, year, round, circuitid, name, date, "time", url, fp1_date, fp1_time, fp2_date, fp2_time, fp3_date, fp3_time, quali_date, quali_time, sprint_date, sprint_time
	WHERE raceid = (SELECT MAX(raceid) FROM public."races")
	FROM public.races;


---- Drivers with DoB, number of races, num poles, wins, pole pos and win in same race, numb podiums
SELECT 
  code,
  name,
  dob,
  COUNT(DISTINCT raceid) AS num_races, 
  COUNT(DISTINCT year) AS num_years,
  COUNT(CASE WHEN grid = 1 THEN 1 END) AS num_pole, 
  COUNT(CASE WHEN position = 1 THEN 1 END) AS num_wins,
  COUNT(CASE WHEN grid = 1 AND position = 1 THEN 1 END) AS num_pole_wins,
  COUNT(CASE WHEN position IN (1,2,3) THEN 1 END) AS num_podiums, 
  COUNT(DISTINCT team) AS num_teams,
  url
FROM public."DriverResults" 
GROUP BY name, code, dob, url
ORDER BY dob DESC