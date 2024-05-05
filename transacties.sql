Werken met transakties
1 Gebruiker
Probeer het basisgebruik van transakties uit voor 1 gebruiker. Dit kan je individueel doen. Let hierbij op de effecten van START TRANSACTION, COMMIT/ROLLBACK, SAVEPOINT

Algemene voorbeeldoefeningen:

-- Start een transactie
START TRANSACTION;

-- Maak een tabel aan (bijv. oliebol)
CREATE TABLE oliebol (
    id SERIAL PRIMARY KEY,
    kleur VARCHAR(50)
);

-- Leg de transactie vast
COMMIT;

-- Controleer of de tabel oliebol bestaat
SELECT * FROM information_schema.tables WHERE table_name = 'oliebol';

-- Start een transactie
START TRANSACTION;

-- Maak de transactie ongedaan
ROLLBACK;

-- Controleer of de tabel oliebol nog bestaat
SELECT * FROM information_schema.tables WHERE table_name = 'oliebol';




-- Start een transactie
START TRANSACTION;

-- Controleer of de tabel "kraam" al bestaat
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'kraam') THEN
        -- Maak de "kraam" tabel aan als deze nog niet bestaat
        CREATE TABLE kraam (
            naam VARCHAR(50),
            type VARCHAR(50)
        );
    END IF;
END $$;

-- Controleer of de tabel "beoordeling" al bestaat
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'beoordeling') THEN
        -- Maak de "beoordeling" tabel aan als deze nog niet bestaat
        CREATE TABLE beoordeling (
            kraam_naam VARCHAR(50),
            waarde INT
        );
    END IF;
END $$;

-- Maak een savepoint aan (bv buikvol)
SAVEPOINT buikvol;

-- Toon de tabel beoordeling
SELECT * FROM beoordeling;

-- Maak de wijzigingen ongedaan tot savepoint buikvol
ROLLBACK TO SAVEPOINT buikvol;

-- Toon de tabel beoordeling
SELECT * FROM beoordeling;

-- Toon de tabel kraam
SELECT * FROM kraam;

-- Leg de wijzigingen vast
COMMIT;

-- Toon de tabel kraam
SELECT * FROM kraam;



Standaardinstellingen:
Zo kom je meer te weten over de standaardinstellingen van de databank.

Voer de volgende instrukties uit en interpreteer hun uitvoer:

SHOW default_transaction_isolation;
SHOW transaction_isolation;
SHOW autocommit;



Meerdere gebruikers:
Probeer het basisgebruik van transakties uit voor meerdere gebruikers. Dus voor deze oefening heb je verschillende gebruikers nodig. Let hierbij op de effecten van START TRANSACTION, COMMIT/ROLLBACK, SAVEPOINT, ISOLATION LEVEL.
-- Gebruiker1 start een transactie
START TRANSACTION;

-- Gebruiker1 maakt een tabel 'koek' aan
CREATE TABLE koek (
    id SERIAL PRIMARY KEY,
    naam VARCHAR(100)
);
-- Gebruiker2 probeert de tabel 'koek' te lezen
SELECT * FROM koek;
-- Gebruiker1 legt de transactie vast
COMMIT;

-- Gebruiker2 probeert opnieuw de tabel 'koek' te lezen
SELECT * FROM koek;


Problemen bij multi-user gebruik
De volgende problemen kunnen worden uitgelokt bij multi-user gebruik:

Dirty Reads: Gebruiker2 leest onbevestigde wijzigingen van Gebruiker1.
Non-Repeatable Reads: Gebruiker2 leest verschillende waarden voor hetzelfde record binnen dezelfde transactie vanwege wijzigingen die zijn aangebracht door Gebruiker1.
Phantom Reads: Gebruiker2 ziet nieuwe rijen die zijn toegevoegd door Gebruiker1 nadat de transactie van Gebruiker2 is gestart.


Het gebruik van ISOLATION LEVEL om problemen te vermijden
Om deze problemen te vermijden, kunnen we verschillende ISOLATION LEVEL-instellingen gebruiken:

READ COMMITTED: Hiermee worden dirty reads voorkomen.
REPEATABLE READ: Hiermee worden dirty reads en non-repeatable reads voorkomen.
SERIALIZABLE: Hiermee worden dirty reads, non-repeatable reads en phantom reads voorkomen.

Je kunt het ISOLATION LEVEL als volgt expliciet instellen:
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
Met deze instellingen kunnen we ervoor zorgen dat de transacties van verschillende gebruikers elkaar niet beïnvloeden op een manier die inconsistentie of onverwachte resultaten veroorzaakt.


Kip ei probleem:
Hoe kunnen we transakties en DEFERRABLE gebruiken om het kip ei probleem op te lossen? Bij het kip ei probleem, verwijzen 2 tabellen naar elkaar. In het begin zijn beide tabellen leeg, hoe kunnen we dan toch data toevoegen aan deze tabellen?

Het "kip-ei" probleem doet zich voor wanneer twee tabellen naar elkaar verwijzen met behulp van vreemde sleutels (foreign keys), maar er geen gegevens kunnen worden toegevoegd aan de tabellen omdat ze naar elkaar verwijzen en beide tabellen leeg zijn.

Dit probleem kan worden opgelost door het gebruik van DEFERRABLE constraints in combinatie met transacties. Een DEFERRABLE constraint stelt de database in staat om de controle van de constraint uit te stellen tot het einde van de transactie, waardoor we gegevens kunnen toevoegen aan beide tabellen en vervolgens de constraints valideren.

Hier is een algemeen stappenplan om het kip-ei probleem op te lossen:

Creëer de tabellen met DEFERRABLE constraints:
Creëer beide tabellen met DEFERRABLE constraints voor de vreemde sleutels.

Voeg gegevens toe aan de tabellen binnen een transactie:
Start een transactie en voeg gegevens toe aan beide tabellen. Omdat de constraints DEFERRABLE zijn, zullen ze niet onmiddellijk worden gevalideerd.

Valideer de constraints aan het einde van de transactie:
Nadat alle gegevens zijn toegevoegd, valideer de constraints aan het einde van de transactie. Als de gegevens correct zijn toegevoegd, worden de constraints gevalideerd en blijft de database consistent.

Hier is een voorbeeld in PostgreSQL-syntax:

-- Stap 1: Creëer tabellen met DEFERRABLE constraints
CREATE TABLE table1 (
    id SERIAL PRIMARY KEY,
    table2_id INT REFERENCES table2(id) DEFERRABLE
);

CREATE TABLE table2 (
    id SERIAL PRIMARY KEY,
    table1_id INT REFERENCES table1(id) DEFERRABLE
);

-- Stap 2: Voeg gegevens toe binnen een transactie
START TRANSACTION;

INSERT INTO table1 (table2_id) VALUES (1);
INSERT INTO table2 (table1_id) VALUES (1);

-- Stap 3: Valideer constraints aan het einde van de transactie
COMMIT;
Dit stelt ons in staat om gegevens toe te voegen aan beide tabellen, zelfs als ze naar elkaar verwijzen, zonder het kip-ei probleem te veroorzaken.


Problemen en Isolatieniveaus:
Welke problemen zijn toegelaten op welk isolatie nivo volgens de standaard? Concrete databanken mogen strenger zijn om te voldoen aan de ISO standaard. Geef een overzicht in tabel vorm van de 5 problemen die we gezien hebben en de isolatie nivos.

Probleem	Isolatieniveaus die het probleem toelaten
Dirty Reads	READ UNCOMMITTED
Non-Repeatable Reads	READ COMMITTED
Phantom Reads	READ COMMITTED, REPEATABLE READ
Lost Updates	READ COMMITTED, REPEATABLE READ, SERIALIZABLE
Uncommitted Dependency	READ COMMITTED, REPEATABLE READ, SERIALIZABLE
Bij hogere isolatieniveaus zoals REPEATABLE READ en SERIALIZABLE worden meer problemen voorkomen omdat deze niveaus strenger zijn en ervoor zorgen dat transacties elkaar minder kunnen beïnvloeden.
