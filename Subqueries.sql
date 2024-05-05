Gebruik voor deze oefeningen de media databank (poort 54321), het chinook schema.
TIP
Wat is het structuur van de tabellen en hun relaties? (het datamodel)
Geef alle artiesten die geen Pop muziek (genre) gemaakt hebben. Mogelijke tussenstappen, je mag het ook rechtstreeks oplossen:

Zoek de genres en artiesten.
Zoek alle artiesten en de genres ze die gespeeld hebben.
Geef nu alle artiesten die geen Pop muziek gemaakt hebben.

Enkele controles:
Zoek alle artiesten die wel Pop muziek gemaakt hebben. Er zou geen overlap mogen zijn.
Hoeveel artiesten zijn er in het totaal? Hoeveel artiesten hebben Pop muziek en hoeveel niet? Klopt deze som?
Probeer nu ook een oplossing te geven met een gecorreleerde subquery.

-- Set the search path to the Chinook schema
SET search_path TO chinook;

-- Query to list all genres
SELECT *
FROM "Genre";

-- Query to list all artists
SELECT *
FROM "Artist";

-- Query to find artists and their associated genres
SELECT g."Name" AS genre, ar."Name" AS artist
FROM "Genre" g
INNER JOIN "Track" t ON g."GenreId" = t."GenreId"
INNER JOIN "Album" al ON t."AlbumId" = al."AlbumId"
INNER JOIN "Artist" ar ON al."ArtistId" = ar."ArtistId";


-- Query to find all artists and the genres they have played
SELECT DISTINCT ar."Name" AS artist, g."Name" AS genre
FROM "Genre" g
INNER JOIN "Track" t ON g."GenreId" = t."GenreId"
INNER JOIN "Album" al ON t."AlbumId" = al."AlbumId"
INNER JOIN "Artist" ar ON al."ArtistId" = ar."ArtistId";

-- Query to find all artists who have not made Pop music
SELECT DISTINCT ar."Name" AS artist
FROM "Artist" ar
WHERE ar."ArtistId" NOT IN (
    SELECT DISTINCT al."ArtistId"
    FROM "Album" al
    INNER JOIN "Track" t ON al."AlbumId" = t."AlbumId"
    INNER JOIN "Genre" g ON t."GenreId" = g."GenreId"
    WHERE g."Name" = 'Pop'
);

-- Query to find all artists who have made Pop music
SELECT DISTINCT ar."Name" AS artist
FROM "Artist" ar
INNER JOIN "Album" al ON ar."ArtistId" = al."ArtistId"
INNER JOIN "Track" t ON al."AlbumId" = t."AlbumId"
INNER JOIN "Genre" g ON t."GenreId" = g."GenreId"
WHERE g."Name" = 'Pop';

-- Query to count the total number of artists
SELECT COUNT(*) AS total_artists FROM "Artist";

-- Query to count the number of artists who made Pop music
SELECT COUNT(DISTINCT ar."ArtistId") AS pop_artists
FROM "Artist" ar
INNER JOIN "Album" al ON ar."ArtistId" = al."ArtistId"
INNER JOIN "Track" t ON al."AlbumId" = t."AlbumId"
INNER JOIN "Genre" g ON t."GenreId" = g."GenreId"
WHERE g."Name" = 'Pop';

-- Query to find all artists who have not made Pop music using a correlated subquery
SELECT DISTINCT ar."Name" AS artist
FROM "Artist" ar
WHERE NOT EXISTS (
    SELECT 1
    FROM "Album" al
    INNER JOIN "Track" t ON al."AlbumId" = t."AlbumId"
    INNER JOIN "Genre" g ON t."GenreId" = g."GenreId"
    WHERE al."ArtistId" = ar."ArtistId"
    AND g."Name" = 'Pop'
);
