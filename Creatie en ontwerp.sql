Refererende actie:
Laat ons veronderstellen dat muziekgroepen meerdere albums kunnen uitbrengen. Zorg dat in je ontwerp minstens aan de volgende voorwaarden voldaan is:
Zorg ervoor dat de standaard muziekgroep TC Matic is wanneer er niets wordt ingevuld bij het album.
Zorg ervoor dat naast een unieke afkorting om als verwijzing te gebruiken, ook de naam van de groep steeds uniek is. Er mag hoogstens 1 groep zonder naam zijn.
Zorg ervoor dat wanneer een muziekgroep verwijderd wordt, hun albums niet verwijdert worden, maar in de plaats hiervan verwijzen naar niets.

Maak de benodigde tabellen en eventuele data aan.

-- Maak de tabel voor muziekgroepen
CREATE TABLE IF NOT EXISTS MusicGroups (
    group_id SERIAL PRIMARY KEY,
    group_name VARCHAR(100) UNIQUE,
    abbreviation VARCHAR(10) UNIQUE,
    -- Standaard muziekgroep
    DEFAULT_TC_Matic BOOLEAN DEFAULT FALSE
);

-- Voeg standaard muziekgroep TC Matic toe
INSERT INTO MusicGroups (group_name, abbreviation, default_tc_matic)
VALUES ('TC Matic', 'TCM', TRUE);

-- Maak de tabel voor albums
CREATE TABLE IF NOT EXISTS Albums (
    album_id SERIAL PRIMARY KEY,
    album_name VARCHAR(100),
    release_year INTEGER,
    group_id INTEGER REFERENCES MusicGroups(group_id) ON DELETE SET NULL
);

-- Voeg wat voorbeeldgegevens toe
INSERT INTO Albums (album_name, release_year, group_id)
VALUES ('First Album', 1980, 1),
       ('Second Album', 1981, NULL); -- Album zonder specifieke groep


Catalogus tabel:
-- Toon alle aanwezige tabellen
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
AND table_type = 'BASE TABLE';

Locale:
-- Om de coderingen van de databanken te zien, moet je ze eerst selecteren
SELECT pg_encoding_to_char(encoding) AS database_encoding
FROM pg_database
WHERE datname IN ('probeer', 'probeer_locale');
