-- Outcomes with each player batting (CASE STATEMENT)
SELECT match_id, team_id, player_id, runs, balls,
CASE WHEN runs= 0 THEN 'Duck!'
WHEN runs BETWEEN 50 AND 100 THEN 'Half Century'
WHEN runs BETWEEN 100 AND 200 THEN 'Century'
WHEN runs>= 200 THEN 'Double Century'
WHEN runs IS NULL THEN 'Did not bat'
ELSE 'Howzat!' END AS outcome
FROM matchruns
