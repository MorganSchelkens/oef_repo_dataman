Hoe kan je met psql naar een database connecteren?
Je kunt verbinding maken met een database in psql door het volgende te typen in je opdrachtprompt of terminal:
psql -d <database> -U <gebruikersnaam> -h <host> -p <poort>
Vervang <database> door de naam van de database waarmee je verbinding wilt maken, <gebruikersnaam> door je gebruikersnaam, <host> door het hostadres van de database en <poort> door de poort waarop de database luistert.

Hoe kan je help over psql weergeven?
Je kunt de help-pagina weergeven door het volgende te typen in psql:
\?

Hoe kan je in psql help over een SQL statement tonen?
Je kunt de syntax en het gebruik van een SQL-statement controleren door het volgende te typen in psql:
\h <sql_statement>

Hoe kan je in psql van een database veranderen?
Om van database te veranderen, typ je het volgende in psql:
\c <nieuwe_database>

Hoe kan je alle tabellen binnen het huidige search_path tonen?
Je kunt alle tabellen binnen het huidige search_path tonen door het volgende te typen in psql:
\dt

Hoe kan je in psql de uitvoer wegschrijven naar een bestand?
Je kunt de uitvoer van een query opslaan in een bestand door het volgende te typen in psql:
\o <bestandsnaam>

Hoe kan je in psql de uitvoer in HTML formaat zetten?
Je kunt de uitvoer in HTML-formaat zetten door het volgende te typen in psql:
\pset format html

Hoe kan je in psql een script inladen en uitvoeren?
Je kunt een script inladen en uitvoeren door het volgende te typen in psql:
\i <script_bestand>

Hoe kan je in psql je historiek tonen?
Je kunt je historiek bekijken door het volgende te typen in psql:
\s

Hoe kan je zien in psql op welke poort je verbonden bent?
Je kunt de verbonden poort zien door het volgende te typen in psql:
\conninfo
Dit zijn de basisopdrachten die je kunt gebruiken in psql om je PostgreSQL-database te beheren en te verkennen.

