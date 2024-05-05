Verbeter
Verbeter de code, maak indien gepast een onderscheid tussen syntax en logische fouten.

Select naam, sum(zwartgeld) Form bank Where sum(zwartgeld)>255;

SELECT count() FROM spelers AS Micheal WHERE naam = "Charlie Skyer";

SELEKT *
FROM   klanten,deelnames;


-- Correctie van syntax- en logische fouten
-- Query 1: Syntaxfouten gecorrigeerd
SELECT naam, SUM(zwartgeld) AS totaal_zwartgeld 
FROM bank 
GROUP BY naam 
HAVING SUM(zwartgeld) > 255;

-- Query 2: Syntax- en logische fouten gecorrigeerd
SELECT COUNT(*) 
FROM spelers 
WHERE naam = 'Charlie Skyer';

-- Query 3: Syntaxfouten gecorrigeerd
SELECT * 
FROM klanten, deelnames;