SELECT przedmiot.nazwa, COUNT(DISTINCT wybor.kod_uz) 
FROM przedmiot
 LEFT JOIN przedmiot_semestr ON przedmiot.kod_przed = przedmiot_semestr.kod_przed
 LEFT JOIN grupa ON grupa.kod_przed_sem = przedmiot_semestr.kod_przed_sem
 LEFT JOIN wybor ON grupa.kod_grupy = wybor.kod_grupy
WHERE rodzaj='k'
GROUP BY przedmiot.kod_przed, przedmiot.nazwa; 
