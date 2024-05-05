Aanmaken objecten:
Meld je aan met je studentnr op de databank probeer
Maak een schema van je favoriete etenswaren, bv broccoli
Maak hieronder een tabel met betrekking op je schema bv bereidingen

Stap 1: Maak de tabel "bereidingen" aan in het schema "favoriete_etenswaren"

CREATE SCHEMA IF NOT EXISTS favoriete_etenswaren;
CREATE TABLE favoriete_etenswaren.bereidingen (
    id SERIAL PRIMARY KEY,
    naam VARCHAR(100),
    bereiding VARCHAR(500)
);

Toekennen rechten:
Zorg dat je local_user in deze tabel lezen en schrijven, maar geen aanpassingen kan doen of data verwijderen.
Uitbreiding: geef je de student die naast je zit ook rechten en laat deze rechten testen door die student.

Stap 2: Ken de juiste rechten toe aan local_user

GRANT SELECT, INSERT ON favoriete_etenswaren.bereidingen TO local_user;
or
REVOKE ALL PRIVILEGES ON TABLE bereidingen FROM local_user;

Testen met local_user:
Meld je aan met je local_user op de databank probeer
Toon de data in de tabel die je net hebt aangemaakt
Voeg data toe aan dit tabel.
Probeer data te verwijderen, dit zou niet mogen lukken

Stap 3: Test de rechten van local_user door gegevens in de tabel te selecteren en gegevens toe te voegen
-- Testen van het selecteren van gegevens
SELECT * FROM favoriete_etenswaren.bereidingen;

-- Testen van het toevoegen van gegevens
INSERT INTO favoriete_etenswaren.bereidingen (naam, bereiding) VALUES ('Broccoli', 'Stomen');

-- Probeer gegevens te verwijderen (zou niet moeten lukken)
DELETE FROM favoriete_etenswaren.bereidingen WHERE id = 1;


Opruimen:
Geef nu alle rechten op de tabel aan je local_user.
Probeer nu de tabel en het schema te verwijderen. Wat merk je?
Hoe kan je dit oplossen?

Stap 4: Intrekken van rechten op de tabel voor local_user en verwijderen van de tabel
REVOKE ALL PRIVILEGES ON TABLE favoriete_etenswaren.bereidingen FROM local_user;
DROP TABLE favoriete_etenswaren.bereidingen;

