--IPL Tables
SELECT * FROM teams
SELECT * FROM venues
SELECT * FROM pott
SELECT * FROM wickets
SELECT * FROM roles
SELECT * FROM players
SELECT * FROM match
SELECT * FROM matchruns

--Player of the Tournament
SELECT p2.name, t.name 
FROM pott p1
JOIN players p2
ON p1.player_id = p2.id
JOIN teams t
ON p1.team_id = t.id

--Scorecard
SELECT match_id, t.name, p1.name, runs, balls, fours, sixes, p2.name, w.dismissal, notes
FROM matchruns AS m
LEFT JOIN teams AS t
ON m.team_id = t.id
LEFT JOIN players AS p1
ON m.player_id = p1.id
LEFT JOIN players AS p2
ON m.bowler_id = p2.id
LEFT JOIN wickets AS w
ON m.wicket_id = w.id

--Matchlist
SELECT m.id, date, v.name AS venue, t1.name AS team1, t2.name AS team2, t3.name AS winner, p.name AS POTM
FROM match m
JOIN venues v
ON m.venue_id = v.id
JOIN teams t1
ON m.teama_id = t1.id
JOIN teams t2
ON m.teamb_id = t2.id
JOIN teams t3
ON m.winner = t3.id
JOIN players AS p
ON m.potm = p.id
ORDER BY m.id

--Most Wickets
SELECT p.name, COUNT(*) AS tournament_wickets
FROM matchruns m
JOIN players p
ON m.bowler_id = p.id
GROUP BY p.name
ORDER BY tournament_wickets DESC

--Most Runs
SELECT p.name, SUM(runs) AS tournament_runs
FROM matchruns m
JOIN players p
ON m.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY tournament_runs DESC

--Most Fours
SELECT p.name, SUM(fours) AS tournament_runs
FROM matchruns m
JOIN players p
ON m.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY tournament_runs DESC

--Most Sixes
SELECT p.name, SUM(sixes) AS tournament_runs
FROM matchruns m
JOIN players p
ON m.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY tournament_runs DESC, p.name

--Number of matches played in each stadium
SELECT v.name, COUNT(*)
FROM match m
JOIN venues v
ON m.venue_id = v.id
GROUP BY v.name
ORDER BY COUNT(*) DESC


--Number of runs scored in the first game of the IPL 
SELECT match_id, team_id, SUM(runs)
FROM matchruns
WHERE match_id = 1001
GROUP BY match_id, team_id
ORDER BY match_id

--Number of runs scored in all games of the IPL
SELECT match_id, t.name, SUM(runs)
FROM matchruns m
JOIN teams t
ON m.team_id = t.id
GROUP BY match_id, t.name
ORDER BY match_id


--Matches that took place at Dubai International Stadium
SELECT * FROM match
JOIN venues 
ON match.venue_id = venues.id
WHERE name = 'Dubai International Stadium'

--Which players were out via Bowled
SELECT * FROM matchruns
JOIN wickets
ON matchruns.wicket_id = wickets.id
WHERE dismissal = 'Bowled'

--Number of stumps/catches made by Rishabh Pant
SELECT * FROM matchruns
WHERE notes LIKE '%Pant'
