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

--Best bowling figures in an innings
SELECT match_id, p.name, COUNT(*) AS wickets
FROM matchruns
JOIN players AS p
ON matchruns.bowler_id = p.id
GROUP BY match_id, p.name
ORDER BY wickets DESC
