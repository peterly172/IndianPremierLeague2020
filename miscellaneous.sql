--StrikeRates for each player 
SELECT p.name, (SUM(runs)/NULLIF(SUM(balls), 0.0)* 100) AS SR
FROM matchruns m
JOIN players p
ON m.player_id = p.id
WHERE runs IS NOT NULL
AND runs != 0
GROUP BY p.name
ORDER BY SR DESC

--Number of Player of the Match Awards
SELECT p.name playerofthematch, COUNT(*)
FROM match
JOIN players AS p
ON match.potm = p.id
GROUP BY p.name
ORDER BY COUNT(*) DESC
