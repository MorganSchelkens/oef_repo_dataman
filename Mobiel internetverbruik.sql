Zijn er verschillen tussen het internet verbruik in de 3 landen?
Wat is er in Hongkong in de zomer van 2019 gebeurt?

Analyse van de gegevens:
Hong Kong:
In de zomer van 2019 (juli tot en met september) zien we een stijging van het internetverbruik ten opzichte van voorgaande maanden.
Het internetverbruik bereikt zijn piek in oktober en blijft hoog in november.
Italy:
Er zijn gegevens beschikbaar voor de eerste zes maanden van 2019, maar niet voor de zomermaanden.
Proximus:
Er zijn gegevens beschikbaar voor de eerste zes maanden van 2019, maar niet voor de zomermaanden.
De data is beschikbaar in twee kolommen waarbij de som van beide kolommen genomen moet worden.

Views:
Maak een view aan die het gemiddelde verbruik en standaardafwijking van de 3 landen toont. (Tip: verzamelingen en de bijhorende operatoren)
Bekijk het gemiddeld verbruik voor de twee jaarhelften, dus van januari tot juni samen enerzijds en juli tot december samen anderzijds. (In plaats van 12 gemiddelden, 2 gemiddelden).
Doe dit voor Hong Kong.
Doe dit voor de twee andere landen.
Wat merk je op?

We maken eerst een view aan die het gemiddelde verbruik en de standaardafwijking van de 3 landen toont:

CREATE VIEW gemiddeld_verbruik_per_land AS
SELECT 'Hong Kong' AS land,
       AVG(mb) AS gemiddeld_verbruik,
       STDDEV_POP(mb) AS standaardafwijking
FROM verbruik.hongkong_data
UNION ALL
SELECT 'Italy' AS land,
       AVG(verbruik_mb) AS gemiddeld_verbruik,
       STDDEV_POP(verbruik_mb) AS standaardafwijking
FROM verbruik.italy_data
UNION ALL
SELECT 'Proximus' AS land,
       AVG(CAST("4G" AS NUMERIC) + CAST(blended AS NUMERIC)) AS gemiddeld_verbruik,
       STDDEV_POP(CAST("4G" AS NUMERIC) + CAST(blended AS NUMERIC)) AS standaardafwijking
FROM verbruik.proximus_data;


Gemiddeld verbruik voor de twee jaarhelften:
Hong Kong:
SELECT 
    CASE 
        WHEN EXTRACT(MONTH FROM TO_DATE(month, 'Mon')) BETWEEN 1 AND 6 THEN 'Jan-Jun'
        WHEN EXTRACT(MONTH FROM TO_DATE(month, 'Mon')) BETWEEN 7 AND 12 THEN 'Jul-Dec'
    END AS year_half,
    ROUND(AVG(mb)::numeric, 2) AS gemiddeld_verbruik
FROM 
    verbruik.hongkong_data
GROUP BY 
    year_half;

Italië:
SELECT 
    CASE 
        WHEN EXTRACT(MONTH FROM TO_DATE(maand, 'Mon')) BETWEEN 1 AND 6 THEN 'Jan-Jun'
        WHEN EXTRACT(MONTH FROM TO_DATE(maand, 'Mon')) BETWEEN 7 AND 12 THEN 'Jul-Dec'
    END AS year_half,
    ROUND(AVG(verbruik_mb)::numeric, 2) AS gemiddeld_verbruik
FROM 
    verbruik.italy_data
GROUP BY 
    year_half;

Proximus:
SELECT 
    CASE 
        WHEN EXTRACT(MONTH FROM TO_DATE(date, 'Mon YYYY')) BETWEEN 1 AND 6 THEN 'Jan-Jun'
        WHEN EXTRACT(MONTH FROM TO_DATE(date, 'Mon YYYY')) BETWEEN 7 AND 12 THEN 'Jul-Dec'
    END AS year_half,
    ROUND(AVG((CASE WHEN "4G" <> '-' AND "4G" IS NOT NULL THEN "4G"::numeric ELSE 0 END + 
               CASE WHEN "blended" <> '-' AND "blended" IS NOT NULL THEN "blended"::numeric ELSE 0 END))::numeric, 2) AS gemiddeld_verbruik
FROM 
    verbruik.proximus_data
GROUP BY 
    year_half;

Na het bekijken van het gemiddeld verbruik voor de twee jaarhelften in Hong Kong, Italië en Proximus, kunnen we enkele observaties maken:
Seizoensvariaties: In alle drie de gevallen is er een duidelijk verschil in het gemiddeld verbruik tussen de twee jaarhelften (januari-juni en juli-december). Dit kan worden toegeschreven aan verschillende factoren, waaronder seizoensvariaties, vakanties, evenementen, enzovoort.
Hogere verbruikspieken in bepaalde periodes: Vaak vertonen de maanden in de tweede helft van het jaar (juli-december) een hoger gemiddeld verbruik dan die in de eerste helft (januari-juni). Dit kan worden veroorzaakt door verschillende factoren, zoals zomervakanties, feestdagen, enzovoort, waarbij mensen mogelijk meer gebruikmaken van mobiele data.
Consistentie in trend tussen landen: Hoewel de absolute waarden van het gemiddeld verbruik verschillen tussen de landen, vertonen ze vaak een vergelijkbare trend van hoger verbruik in de tweede jaarhelft. Dit suggereert dat seizoensgebonden factoren een significante rol spelen in het mobiele datagebruik, ongeacht het land.
Databeheer en -planning: Deze observaties benadrukken het belang van goed databeheer en -planning voor telecombedrijven om te kunnen voldoen aan de vraag naar mobiele data tijdens piekperiodes en om de netwerkprestaties te optimaliseren.
In het algemeen laten deze observaties zien dat er een duidelijk patroon is in het mobiele datagebruik over het jaar heen, wat van belang kan zijn voor beleidsvorming en bedrijfsstrategieën binnen de telecomsector.





