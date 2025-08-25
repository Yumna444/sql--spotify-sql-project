# 🎵 Advanced SQL Project – Spotify Dataset
This project explores SQL for Data Analysis using a Spotify dataset. It includes table creation, data cleaning (EDA), and queries of different difficulty levels ranging from basic selections to advanced window functions and CTEs.
## 📌 Project Overview
The project demonstrates how to use PostgreSQL and pgAdmin/psql to:
- Create and manage tables
- Perform data cleaning & EDA
- Write SQL queries for easy, medium, and advanced analysis
- Apply aggregate functions, window functions, and CTEs
## 📂 Table Schema
The project creates a table named `spotify` with the following columns:
| Column | Type | Description |
|--------|------|-------------|
| artist | VARCHAR | Name of the artist |
| track | VARCHAR | Track name |
| album | VARCHAR | Album name |
| album_type | VARCHAR | Album type (album/single) |
| danceability | FLOAT | Danceability score (0–1) |
| energy | FLOAT | Energy score (0–1) |
| loudness | FLOAT | Loudness in dB |
| speechiness | FLOAT | Speechiness score (0–1) |
| acousticness | FLOAT | Acousticness score (0–1) |
| instrumentalness | FLOAT | Instrumentalness score (0–1) |
| liveness | FLOAT | Liveness score (0–1) |
| valence | FLOAT | Musical positivity (0–1) |
| tempo | FLOAT | Tempo (BPM) |
| duration_min | FLOAT | Duration in minutes |
| title | VARCHAR | YouTube video title |
| channel | VARCHAR | YouTube channel name |
| views | FLOAT | YouTube views |
| likes | BIGINT | YouTube likes |
| comments | BIGINT | YouTube comments |
| licensed | BOOLEAN | Whether track is licensed |
| official_video | BOOLEAN | Whether official video exists |
| stream | BIGINT | Spotify streams |
| energy_liveness | FLOAT | Derived feature |
| most_played_on | VARCHAR | Platform where most played |
## 🔍 Exploratory Data Analysis (EDA)
- Count total rows and unique artists  
```sql
SELECT COUNT(*) FROM spotify;
SELECT COUNT(DISTINCT artist) FROM spotify;

Retrieve the names of all tracks that have more than 1 billion streams

SELECT track FROM spotify WHERE stream > 1000000000;

List all albums along with their respective artists

SELECT DISTINCT album, artist FROM spotify ORDER BY album;


Get the total number of comments for tracks where licensed = TRUE

SELECT SUM(comments) AS total_comments FROM spotify WHERE licensed = TRUE;


Find all tracks that belong to the album type single

SELECT track FROM spotify WHERE album_type = 'single';


Count the total number of tracks by each artist

SELECT artist, COUNT(track) AS total_tracks FROM spotify GROUP BY artist ORDER BY total_tracks DESC;


Calculate the average danceability of tracks in each album

SELECT album, AVG(danceability) AS avg_danceability FROM spotify GROUP BY album ORDER BY avg_danceability DESC;


Find the top 5 tracks with the highest energy values

SELECT track, artist, energy FROM spotify ORDER BY energy DESC LIMIT 5;

List all tracks along with their views and likes where official_video = TRUE

SELECT track, views, likes FROM spotify WHERE official_video = TRUE;


For each album, calculate the total views of all associated tracks

SELECT album, SUM(views) AS total_views FROM spotify GROUP BY album ORDER BY total_views DESC;


Retrieve the track names that have been streamed on Spotify more than YouTube

SELECT track FROM spotify WHERE stream > views;


Find the top 3 most-viewed tracks for each artist using window functions

SELECT artist, track, views FROM (
  SELECT artist, track, views,
         ROW_NUMBER() OVER (PARTITION BY artist ORDER BY views DESC) AS rn
  FROM spotify
) AS ranked
WHERE rn <= 3
ORDER BY artist, views DESC;


Write a query to find tracks where the liveness score is above the average

SELECT track, artist, liveness FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify)
ORDER BY liveness DESC;


Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album

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

15 Practice Questions

--Easy Level

Retrieve the names of all tracks that have more than 1 billion streams.
List all albums along with their respective artists.
Get the total number of comments for tracks where licensed = TRUE.
Find all tracks that belong to the album type single.
Count the total number of tracks by each artist.


--Medium Level


Calculate the average danceability of tracks in each album.
Find the top 5 tracks with the highest energy values.
List all tracks along with their views and likes where official_video = TRUE.
For each album, calculate the total views of all associated tracks.
Retrieve the track names that have been streamed on Spotify more than YouTube.


--Advanced Level


Find the top 3 most-viewed tracks for each artist using window functions.
Write a query to find tracks where the liveness score is above the average.
Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.


⚡ Key Learnings

Writing SQL queries of increasing complexity

Using aggregate functions (SUM, AVG, MAX, MIN)

Applying window functions (ROW_NUMBER)

Using CTEs for cleaner advanced queries

Performing data cleaning in SQL

🚀 How to Run

Clone this repository

Open pgAdmin / psql

Run the table creation script

Import your Spotify dataset into the spotify table

Execute queries from the script

