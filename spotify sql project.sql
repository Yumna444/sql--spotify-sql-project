-- Advanced SQL project
-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

--EDA 
Select count(*) from spotify;

select count (distinct artist) from spotify;

select distinct album_type from spotify;

select max (duration_min) from spotify;

select min (duration_min) from spotify;

select*from spotify
where duration_min = 0;

delete from spotify
where duration_min = 0;
select*from spotify
where duration_min = 0;

select distinct distinct from spotify;

select distinct most_played_on from spotify;

-------
---Data Analysis - easy category
-------
--1-Retrieve the names of all tracks that have more than 1 billion streams.
--2-List all albums along with their respective artists.
--3-Get the total number of comments for tracks where licensed = TRUE.
--4-Find all tracks that belong to the album type single.
--5-Count the total number of tracks by each artist.

1- SELECT track
FROM spotify
WHERE spotify.stream > 1000000000;

2-SELECT
      DISTINCT album, artist
FROM spotify
order by 1

3-SELECT
      SUM(comments) AS total_comments
FROM spotify
WHERE licensed = TRUE;

4-SELECT track
FROM spotify
WHERE album_type = 'single';

5- SELECT artist, 
      COUNT(track) AS total_tracks
FROM spotify
GROUP BY artist
ORDER BY total_tracks DESC;

---------
--Medium level
----
--1-Calculate the average danceability of tracks in each album.
--2-Find the top 5 tracks with the highest energy values.
--3-List all tracks along with their views and likes where official_video = TRUE.
--4-For each album, calculate the total views of all associated tracks.
--5-Retrieve the track names that have been streamed on Spotify more than YouTube.

1- SELECT album, 
      AVG(danceability) AS avg_danceability
FROM spotify
GROUP BY album
ORDER BY avg_danceability DESC;

2- SELECT track, artist, energy
FROM spotify
ORDER BY energy DESC
LIMIT 5;


3-SELECT track, views, likes
FROM spotify
WHERE official_video = TRUE;

4-SELECT album,
     SUM(views) AS total_views
FROM spotify
GROUP BY album
ORDER BY total_views DESC;

5-SELECT track
FROM spotify
WHERE spotify.stream > views;

--Advanced level
----
--1-Find the top 3 most-viewed tracks for each artist using window functions.
--2-Write a query to find tracks where the liveness score is above the average.
--3-Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

--1 
SELECT artist, track, views
FROM (
  SELECT
    artist,
    track,
    views,
    ROW_NUMBER() OVER (PARTITION BY artist ORDER BY views DESC) AS rn
  FROM spotify
) AS ranked
WHERE rn <= 3
ORDER BY artist, views DESC;

==2= SELECT track, artist, liveness
FROM spotify
WHERE liveness > (
  SELECT AVG(liveness) FROM spotify
)
ORDER BY liveness DESC;

--3- 
WITH cte
AS
(SELECT 
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energery
FROM spotify
GROUP BY 1
)
SELECT 
	album,
	highest_energy - lowest_energery as energy_diff
FROM cte
ORDER BY 2 DESC

	  



