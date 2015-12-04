use EDCFootball;

Create Schema football;
CREATE TABLE football.season(
	id INT PRIMARY KEY,
	link_fixtures_href text,
	link_leagueTable_href text,
	link_self_href text,
	link_teams_href text,
	caption text,
	last_updated text,
	league text,
	numberOfGames INT,
	numberOfTeams INT,
	seasonYear text
);

CREATE TABLE football.team(
	id INT PRIMARY KEY,
	link_fixtures_href text,
	link_players_href text,
	link_self_href text,
	name text,
	code text,
	shortName text,
	squadMarketValue text,
	crestURL text
);

CREATE TABLE football.teamSeason(
	seasonID INT REFERENCES football.season(id),
	teamID INT REFERENCES football.team(id)
);

CREATE TABLE football.player(
	id INT PRIMARY KEY IDENTITY,
	name text,
	position text,
	jerseyNumber INT,
	dateOfBirth text,
	nationality text,
	contractUntil text,
	marketValue text
);

CREATE TABLE football.teamplayer(
	playerID int REFERENCES football.player(id),
	seasonID int REFERENCES football.season(id)
);

CREATE TABLE football.teamSubscription(
	userID NVARCHAR(128) REFERENCES dbo.AspNetUsers(Id),
	teamID int REFERENCES football.team(id)
);

CREATE TABLE football.teamNew(
	id INT UNIQUE IDENTITY,
	title text,
	link varchar(350),
	description text,
	team_id int REFERENCES football.team(id),
	pubDate datetime,
	PRIMARY KEY(link, team_id)
);

CREATE TABLE football.teamRelatedNew(
	id INT UNIQUE IDENTITY,
	title text,
	link varchar(350),
	related_id int REFERENCES football.teamNew(id),
	team_id int REFERENCES football.team(id),
	PRIMARY KEY(link, team_id)
);



