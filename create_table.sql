CREATE TABLE match (
id INT PRIMARY KEY,
date DATE,
venue_id INT,
teama_id INT NOT NULL,
teamb_id INT NOT NULL,
winner INT,
potm INT 
);

CREATE TABLE pott (
id SERIAL PRIMARY KEY,
player_id INT NOT NULL,
team_id INT NULL
)

CREATE TABLE teams (
id SERIAL PRIMARY KEY, 
name VARCHAR(50) NOT NULL,
coach VARCHAR(50) NOT NULL
);

CREATE TABLE venues (
id SERIAL PRIMARY KEY,
name VARCHAR(50),
city VARCHAR(50)
);

CREATE TABLE roles (
id SERIAL PRIMARY KEY NOT NULL,
role VARCHAR(25) NOT NULL
);

CREATE TABLE wickets (
id SERIAL PRIMARY KEY,
dismissal VARCHAR(25)
);

CREATE TABLE players (
id INT PRIMARY KEY NOT NULL,
name VARCHAR(50) NOT NULL,
role_id INT NOT NULL,
team_id INT NOT NULL
);

CREATE TABLE matchruns(
match_id INT NOT NULL,
team_id INT NOT NULL,
player_id INT,
runs INT,
balls INT,
fours INT,
sixes INT,
bowler_id INT,
wicket_id INT,
notes VARCHAR(100)
);

