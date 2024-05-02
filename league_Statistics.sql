CREATE TABLE Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(255)
);

CREATE TABLE Matches (
    home_team_id INT,
    away_team_id INT,
    home_team_goals INT,
    away_team_goals INT,
    PRIMARY KEY (home_team_id, away_team_id)
    );

INSERT INTO Teams (team_id, team_name) VALUES
(1, 'Ajax'),
(4, 'Dortmund'),
(6, 'Arsenal');

INSERT INTO Matches (home_team_id, away_team_id, home_team_goals, away_team_goals) VALUES
(1, 4, 0, 1),
(1, 6, 3, 3),
(4, 1, 5, 2),
(6, 1, 0, 0);

SELECT * FROM Teams;
SELECT * FROM Matches;

# League Statistics Solution
WITH CTE AS ((SELECT home_team_id AS r1, away_team_id AS r2, home_team_goals AS g1, away_team_goals AS g2
FROM Matches)
UNION ALL
(SELECT away_team_id AS r1, home_team_id AS r2, away_team_goals AS g1,home_team_goals AS g1
FROM Matches))
SELECT t.team_name, 
COUNT(c.r1) AS'matches_played',
SUM(CASE
		WHEN c.g1>c.g2 THEN 3
        WHEN c.g1 = c.g2 THEN 1
        ELSE 0
	END
    ) AS 'points',
SUM(c.g1) AS 'goal_for',
SUM(c.g2) AS 'goal_against',
SUM(c.g1) - SUM(c.g2) AS 'goal_diff'
FROM Teams t
INNER JOIN CTE c
ON t.team_id = c.r1
GROUP BY c.r1
ORDER BY points DESC, goal_diff DESC, team_name;
