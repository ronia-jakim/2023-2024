SELECT  uzytkownik.kod_uz,
        uzytkownik.imie,
        uzytkownik.nazwisko
FROM uzytkownik 
  JOIN grupa ON uzytkownik.kod_uz = grupa.kod_uz
WHERE rodzaj_zajec = 'w'
EXCEPT DISTINCT 
SELECT  uzytkownik.kod_uz,
        uzytkownik.imie,
        uzytkownik.nazwisko
FROM uzytkownik 
  JOIN grupa ON uzytkownik.kod_uz = grupa.kod_uz
WHERE rodzaj_zajec = 's'
