--Running total of runs
SELECT match_id, t.name AS team, p.name AS players, runs,
SUM(runs) OVER(ORDER BY match_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM matchruns AS m
LEFT JOIN teams AS t
ON m.team_id = t.id
LEFT JOIN players AS p
ON m.player_id = p.id

--Running average of runs
SELECT match_id, t.name AS team, p.name AS players, runs, 
AVG(runs) OVER(ORDER BY match_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_avg
FROM matchruns AS m
LEFT JOIN teams AS t
ON m.team_id = t.id
LEFT JOIN players AS p
ON m.player_id = p.id
WHERE runs IS NOT NULL

--Number of Overs played in a game
SELECT match_id, t.name, ROUND(SUM(balls/6.0), 2) AS overs
FROM matchruns m
JOIN teams t
ON m.team_id = t.id
WHERE runs IS NOT NULL
GROUP BY match_id, t.name
ORDER BY overs DESC

--Run ranges by a player (David Warner)
WITH bins AS (
SELECT generate_series(0, 90, 10) AS lower,
generate_series(10, 100, 10) AS upper),
runs AS (SELECT player_id, runs FROM matchruns)
SELECT lower, upper, count(runs)
FROM bins
JOIN runs
ON runs >= lower
AND runs < upper
WHERE player_id = 2803
GROUP BY lower, upper
ORDER BY lower

-- Number of balls within a range
WITH bins AS (
SELECT generate_series (0, 600, 50) AS lower,
generate_series (50, 650, 50) AS upper),
balls AS (
SELECT balls FROM matchruns)
SELECT lower, upper, COUNT(*)
FROM bins
JOIN balls
ON balls >= lower
AND balls < upper
GROUP BY lower, upper
ORDER BY lower

--Mean and Median of runs made per venue
SELECT v.name AS venue, ROUND(AVG(runs), 2) AS mean, percentile_disc(0.5)
WITHIN GROUP (ORDER BY runs) AS median_runs
FROM matchruns
LEFT JOIN match AS m
ON matchruns.match_id = m.id
LEFT JOIN venues AS v
ON m.venue_id = v.id
GROUP BY v.name
ORDER BY mean


-- Mean and Median of runs made per player
SELECT p.name AS player, ROUND(AVG(runs), 2) AS mean, percentile_disc(0.5)
WITHIN GROUP (ORDER BY runs) AS median_runs
FROM matchruns AS m
LEFT JOIN players AS p
ON m.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY mean DESC

-- Mean and Median of fours made per player
SELECT p.name AS player, ROUND(AVG(fours), 2) AS mean, percentile_disc(0.5)
WITHIN GROUP (ORDER BY fours) AS median_runs
FROM matchruns AS m
LEFT JOIN players AS p
ON m.player_id = p.id
WHERE fours IS NOT NULL
GROUP BY p.name
ORDER BY mean DESC
