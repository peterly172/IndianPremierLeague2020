--  Players with the most wickets in the tournament
SELECT p.name, COUNT(*) AS wickets
FROM matchruns
JOIN players AS p
ON matchruns.bowler_id = p.id
GROUP BY p.name
ORDER BY wickets DESC

--  Players with the most wickets in pre playoffs
SELECT p.name, COUNT(*) AS wickets
FROM matchruns
JOIN players AS p
ON matchruns.bowler_id = p.id
WHERE match_id BETWEEN 1001 AND 1056
GROUP BY p.name
ORDER BY wickets DESC

--  Players with the most wickets during playoffs
SELECT p.name, COUNT(*) AS wickets
FROM matchruns
JOIN players AS p
ON matchruns.bowler_id = p.id
WHERE match_id BETWEEN 1057 AND 1060
GROUP BY p.name
ORDER BY wickets DESC


-- Number of wins from each team
SELECT t.name, COUNT(*) AS wins
FROM match m
JOIN teams t
ON m.winner = t.id
WHERE m.id BETWEEN 1001 AND 1056
GROUP BY t.name
ORDER BY wins DESC

--Number of matches played by each player during the series
SELECT p.name, COUNT(*) AS innings
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
GROUP BY p.name
ORDER BY innings DESC

--Number of ducks made in the IPL
SELECT p.name, runs, COUNT(*) AS ducks
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs= 0
AND wicket_id != 6
GROUP BY p.name, runs
ORDER BY COUNT(*) DESC

-- Players with the most runs during the series
SELECT p.name, SUM(runs) AS total_runs
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY total_runs DESC

-- Players with the most runs pre playoffs
SELECT p.name, SUM(runs) AS total_runs
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
AND match_id BETWEEN 1001 AND 1056
GROUP BY p.name
ORDER BY total_runs DESC

-- Players with the most runs during playoffs
SELECT p.name, SUM(runs) AS total_runs
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
AND match_id BETWEEN 1057 AND 1060
GROUP BY p.name
ORDER BY total_runs DESC

-- Highest Scores in the IPL
SELECT match_id, p.name, SUM(runs) AS total_runs
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY match_id, p.name
ORDER BY total_runs DESC

--Number of balls faced in descending order
SELECT p.name, SUM(balls) AS total_balls
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY total_balls DESC

--Most Boundaries by a player in IPL
SELECT p.name, SUM(fours + sixes) AS total_boundaries
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY total_boundaries DESC

--Most sixes per game in IPL
SELECT p.name, SUM(fours) AS fours, SUM(sixes) AS sixes
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY sixes DESC


-- Most runs scored in an innings in the series
SELECT p.name, MAX(runs) AS maxruns
FROM matchruns AS m
JOIN players AS p
ON m.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY maxruns DESC
