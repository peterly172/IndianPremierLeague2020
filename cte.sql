--Number of players who reach half-centuries in each venue
WITH hc AS(
SELECT match_id
FROM matchruns WHERE runs >= 50)
SELECT v.name, COUNT(h.match_id) AS half_century
FROM match AS m
LEFT JOIN venues AS v
ON m.venue_id = v.id
JOIN hc AS h
ON h.match_id = m.id
GROUP BY v.name
ORDER BY half_century DESC

WITH hc AS(
SELECT match_id
FROM matchruns WHERE runs >= 100)
SELECT v.name, COUNT(h.match_id) AS century
FROM match AS m
LEFT JOIN venues AS v
ON m.venue_id = v.id
JOIN hc AS h
ON h.match_id = m.id
GROUP BY v.name
ORDER BY century DESC
