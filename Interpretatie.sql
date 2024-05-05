Cartesisch product:
Gecorreleerde subquery:
Gegeven zijn de volgende tabellen t1 en t2

Voor de eerste query:
SELECT  t1.nr, t1.k1,
    (SELECT count(*)
    FROM    t2
    WHERE   t2.nr = t1.nr)
FROM    t1, t2
WHERE   t1.nr < 3;

De uitvoer van deze query is:
nr	k1	count
1		1
1		1
2		1
2		1
Het resultaat geeft elke rij van t1 weer waarvan nr kleiner is dan 3, samen met het aantal overeenkomstige rijen in t2 voor elke rij van t1.

Ja, deze query kan ook zonder subquery worden geschreven met behulp van een LEFT JOIN:


SELECT t1.nr, t1.k1, COUNT(t2.nr) AS count
FROM t1
LEFT JOIN t2 ON t1.nr = t2.nr
WHERE t1.nr < 3
GROUP BY t1.nr, t1.k1;

Voor de tweede query:
SELECT  count(*), max(k.hematocrietgemiddelde)
FROM    wk w cross join wk k
GROUP BY w.goals;

De uitvoer van deze query is:
count	max
9	53
9	53
Deze query geeft het aantal rijen in de gekruiste join tussen wk en k voor elke waarde van goals en de maximale waarde van hematocrietgemiddelde voor elke groep.

Voor de derde query:
SELECT  count(*), sum(k.goals)
FROM    wedstrijden w inner join wedstrijden k on (w.goals=k.goals)
WHERE   w.goals = k.goals
GROUP BY w.goals;

De uitvoer van deze query is:
count	sum
3	52
Deze query telt het aantal rijen in de inner join tussen wedstrijden en k waar de doelpunten gelijk zijn, en berekent de som van de doelpunten voor elke groep