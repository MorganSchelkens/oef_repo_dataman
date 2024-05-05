We willen een zicht krijgen op hoeveel liedjes elke artiest gemaakt heeft, zowel wat betreft aantal als speelduur.

Geef voor elke artist het aantal albums en aantal tracks dat deze gemaakt heeft. Toon ook het aantal artisten.
SET search_path TO chinook;

SELECT 
    "ArtistId",
    "Artist"."Name" AS artist_name, -- Specify the table name or alias to disambiguate the column reference
    COUNT(DISTINCT "AlbumId") AS aantal_albums,
    COUNT("TrackId") AS aantal_tracks
	
FROM 
    "Album"
JOIN 
    "Artist" USING("ArtistId")
JOIN
    "Track" USING("AlbumId")
GROUP BY 
    "ArtistId", "Artist"."Name" -- Specify the table name or alias to disambiguate the column reference
ORDER BY 
    "Artist"."Name"; -- Specify the table name or alias to disambiguate the column reference

Geef voor elke artist de totale duur aan liedjes dat deze gemaakt heeft. Toon dit ook voor elk album en de totaalduur.
SET search_path TO chinook;

SELECT 
    "Artist"."Name" AS artist_name,
    "Album"."Title" AS album_title,
    SUM("Track"."Milliseconds") AS total_duration
FROM 
    "Artist"
LEFT JOIN 
    "Album" ON "Artist"."ArtistId" = "Album"."ArtistId"
LEFT JOIN
    "Track" ON "Album"."AlbumId" = "Track"."AlbumId"
GROUP BY 
    "Artist"."Name", "Album"."Title";


Uitbreiding:

Toon extra kolommen met dezelfde berekeningen waarbij enkel rekening wordt gehouden met liedjes die langer zijn dan 1 minuut.
SET search_path TO chinook;
SELECT 
    "Artist"."Name" AS artist_name,
    COUNT(CASE WHEN "Track"."Milliseconds" > 60000 THEN 1 END) AS aantal_tracks_over_1_minute,
    SUM(CASE WHEN "Track"."Milliseconds" > 60000 THEN "Track"."Milliseconds" END) AS total_duration_over_1_minute
FROM 
    "Artist"
LEFT JOIN 
    "Album" ON "Artist"."ArtistId" = "Album"."ArtistId"
LEFT JOIN
    "Track" ON "Album"."AlbumId" = "Track"."AlbumId"
GROUP BY 
    "Artist"."Name";

Toon de relatieve aantallen en speelduren, ipv de absolute aantallen. De som van deze relatieve getallen zou dus telkens 100% moeten zijn.
SET search_path TO chinook;
WITH TotalCounts AS (
    SELECT 
        COUNT(*) AS total_tracks,
        SUM("Milliseconds") AS total_duration
    FROM 
        "Track"
),
ArtistStats AS (
    SELECT 
        "Artist"."Name" AS artist_name,
        COUNT("Track"."TrackId") AS total_tracks,
        SUM("Track"."Milliseconds") AS total_duration,
        COUNT(CASE WHEN "Track"."Milliseconds" > 60000 THEN 1 END) AS tracks_over_1_minute,
        SUM(CASE WHEN "Track"."Milliseconds" > 60000 THEN "Track"."Milliseconds" END) AS total_duration_over_1_minute
    FROM 
        "Artist"
    LEFT JOIN 
        "Album" ON "Artist"."ArtistId" = "Album"."ArtistId"
    LEFT JOIN
        "Track" ON "Album"."AlbumId" = "Track"."AlbumId"
    GROUP BY 
        "Artist"."Name"
)
SELECT 
    artist_name,
    ArtistStats.total_tracks,
    ArtistStats.total_duration,
    ArtistStats.tracks_over_1_minute,
    ArtistStats.total_duration_over_1_minute,
    CASE WHEN tc.total_tracks <> 0 THEN ROUND(ArtistStats.total_tracks * 100.0 / tc.total_tracks, 2) ELSE NULL END AS relative_tracks_percentage,
    CASE WHEN tc.total_duration <> 0 THEN ROUND(ArtistStats.total_duration * 100.0 / tc.total_duration, 2) ELSE NULL END AS relative_duration_percentage,
    CASE WHEN ArtistStats.total_tracks <> 0 THEN ROUND(ArtistStats.tracks_over_1_minute * 100.0 / ArtistStats.total_tracks, 2) ELSE NULL END AS relative_tracks_over_1_minute_percentage,
    CASE WHEN ArtistStats.total_duration <> 0 THEN ROUND(ArtistStats.total_duration_over_1_minute * 100.0 / ArtistStats.total_duration, 2) ELSE NULL END AS relative_duration_over_1_minute_percentage
FROM 
    ArtistStats, TotalCounts tc;

Is er rekening gehouden met alle tracks in de databank?

Hoe kan je grouping sets gebruiken?
SET search_path TO chinook;
SELECT 
    "Artist"."Name" AS artist_name,
    COUNT(DISTINCT "Album"."AlbumId") AS aantal_albums,
    COUNT("Track"."TrackId") AS aantal_tracks,
    SUM("Track"."Milliseconds") AS total_duration
FROM 
    "Artist"
LEFT JOIN 
    "Album" ON "Artist"."ArtistId" = "Album"."ArtistId"
LEFT JOIN
    "Track" ON "Album"."AlbumId" = "Track"."AlbumId"
GROUP BY 
    GROUPING SETS (("Artist"."Name"), (("Artist"."Name"), ("Album"."Title")));

