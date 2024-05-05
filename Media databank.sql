Chinook Schema:
Geef voor elk album de 2 langste nummers (tracks). (Dus alle albums moeten getoond worden). Toon de naam van het album, het nummer en de tijd.

set search_path to chinook;

SELECT 
    "a"."Title" AS "Album",
    "t"."Name" AS "Track",
    "t"."Milliseconds" AS "Time"
FROM 
    "Album" "a"
INNER JOIN (
    SELECT 
        "AlbumId",
        "Name",
        "Milliseconds",
        ROW_NUMBER() OVER (PARTITION BY "AlbumId" ORDER BY "Milliseconds" DESC) AS "track_rank"
    FROM 
        "Track"
) "t" ON "a"."AlbumId" = "t"."AlbumId"
WHERE 
    "t"."track_rank" <= 2;
