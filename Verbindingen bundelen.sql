Prepared Statements:
In welke vormen (sessie, transaktie, instruktie) kan je op welke manier prepared statements hergebruiken?

Inzicht:
Stel er is sessie pooling. Hoeveel databank verbindingen zijn er minstens nodig voor 10 verschillende gebruikers die naar een databank willen verbinden (via pooling).

Sessie-pooling:

Bij sessie-pooling wordt een verbinding alleen gemaakt voor een gebruiker wanneer deze een nieuwe sessie start. Prepared statements kunnen worden hergebruikt gedurende de hele sessie van de gebruiker.
Ze kunnen worden voorbereid aan het begin van de sessie en hergebruikt worden voor verschillende instructies binnen dezelfde sessie.
Ze kunnen ook binnen verschillende transacties worden hergebruikt zolang de sessie actief is.

Stel er is transaktie pooling. Hoeveel databank verbindingen zijn er minstens nodig voor 10 verschillende gebruikers die naar een databank willen verbinden (via pooling).

Stel er is transaktie pooling. Hoeveel databank verbindingen zijn er minstens nodig voor 10 verschillende gebruikers die naar een databank willen verbinden (via pooling). Er zijn 2 gebruikers die soms expliciet transacties gebruiken.

Transactie-pooling:

Bij transactie-pooling wordt een nieuwe verbinding gemaakt voor elke transactie die wordt gestart. Prepared statements kunnen alleen worden hergebruikt binnen dezelfde transactie.
Eenmaal voorbereid binnen een transactie, kunnen ze worden hergebruikt voor verschillende instructies binnen dezelfde transactie.
Prepared statements kunnen niet worden hergebruikt tussen verschillende transacties.

Stel er is instruktie pooling. Hoeveel databank verbindingen zijn er minstens nodig voor 10 verschillende gebruikers die naar een databank willen verbinden (via pooling).

Instructie-pooling:

Bij instructie-pooling wordt een nieuwe verbinding gemaakt voor elke instructie die naar de database wordt gestuurd. Prepared statements kunnen alleen worden hergebruikt binnen dezelfde instructie.
Ze kunnen meerdere keren worden gebruikt binnen dezelfde instructie, maar niet tussen verschillende instructies.


Het aantal benodigde databaseverbindingen voor pooling hangt af van het type pooling en het gedrag van de gebruikers:

Sessie-pooling: Minimaal 10 verbindingen zijn nodig, omdat elke gebruiker een afzonderlijke sessie heeft en deze tegelijkertijd kan openen.

Transactie-pooling: Als alle 10 gebruikers altijd transacties gebruiken, zijn er minstens 10 verbindingen nodig. Als slechts 2 gebruikers soms transacties gebruiken, zijn er minstens 2 verbindingen nodig om tegemoet te komen aan hun behoeften.

Instructie-pooling: Hier is het aantal benodigde verbindingen gelijk aan het aantal gebruikers, omdat voor elke instructie een nieuwe verbinding wordt gemaakt.

Let op dat deze aantallen kunnen variëren afhankelijk van factoren zoals de maximale gelijktijdige verbindingen die zijn toegestaan in de databaseconfiguratie en de mate van parallelisme van de gebruikersinteracties.