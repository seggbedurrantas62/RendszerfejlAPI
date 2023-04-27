

--egyszerre egy insert futtatása elemenként a Megrendelés táblánál



					--INSERT only (allapot, megrendeles_id)
					select * from Projekt
		
CREATE TABLE Projekt(
					projekt_id INT IDENTITY PRIMARY KEY,
					allapot VARCHAR(40) CHECK (allapot IN('New', 'Draft', 'Wait', 'Scheduled', 'InProgress','Completed','Failed')),
					megrendeles_id INT REFERENCES Megrendeles ON UPDATE CASCADE ON DELETE CASCADE,
					datum DATE DEFAULT(GETDATE()),
					osszeg INT)


					
					--INSERT only (elem_id,elem_db,szukseges_keszlet,foglalt)
CREATE TABLE Megrendeles(
						megrendeles_id INT IDENTITY PRIMARY KEY,
						elem_id INT REFERENCES Alkatresz ON UPDATE CASCADE ON DELETE CASCADE,
						elem_db INT,
						szukseges_keszlet INT,
						elofoglalt_keszlet INT,
						szabad_keszlet INT,
						foglalt BIT DEFAULT 0 CHECK(foglalt IN(0,1)),
						lefoglalando_keszlet INT
						)
						

						--INSERT only (elem_id,sor,oszlop,szint,rekesz_meret,tartalmaz_db)
CREATE TABLE Raktar(
					rekesz_id INT IDENTITY PRIMARY KEY,
					elem_id INT REFERENCES Alkatresz ON UPDATE CASCADE ON DELETE SET NULL,
					sor INT,
					oszlop INT,
					szint INT,
					rekesz_meret INT)


ALTER TABLE Raktar
ADD tartalmaz_db INT


Alter Table Raktar
ADD Constraint CHECK_SOR CHECK(sor BETWEEN 1 AND 9);


Alter Table Raktar
ADD Constraint CHECK_OSZLOP CHECK(oszlop BETWEEN 1 AND 9);
 
 
Alter Table Raktar
ADD Constraint CHECK_SZINT CHECK(szint BETWEEN 1 AND 9);


					-- INSERT only (elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
CREATE TABLE Alkatresz(
						elem_id INT IDENTITY PRIMARY KEY,
						elem_nev VARCHAR(40),
						elem_ar INT,
						meret INT,
						keszlet INT,
						lefoglalt_keszlet INT,
						alkatresz_allapot VARCHAR(40))

ALTER TABLE Alkatresz
DROP COLUMN alkatresz_allapot

ALTER TABLE Alkatresz
ADD alkatresz_allapot VARCHAR(10)


Alter Table Alkatresz
ADD Constraint CHECK_ALLAPOT CHECK(alkatresz_allapot IN('elerheto','nem_elerheto'));

------------------Alkatrész insertek eleje-------------------------------
						
INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('JA Solar 410 W napelem',67000 ,21 ,410 ,'elerheto')

INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('JA Solar 360 W napelem',60000 ,20 ,1000 ,'elerheto')

INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('JA Solar 375 W napelem',62000 ,20 ,1000 ,'elerheto')

INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('Canadian Solar CS3K-320 W napelem',55000 ,20 ,1000 ,'elerheto')


INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('Sungrow SG2.5RS-S inverter',550000 ,33 ,1000 ,'elerheto')


INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('Sungrow RT inverter',850000 ,36 ,1000 ,'elerheto')


INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('Sungrow CX inverter',950000 ,37 ,1000 ,'elerheto')


INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('Fronius Galvo inverter',650000 ,33 ,1000 ,'elerheto')


INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('Fronius Symo inverter',750000 ,35 ,1000 ,'elerheto')


INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('Fronius Eco inverter',730000 ,34 ,1000 ,'elerheto')


INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('SolarEdge HD Wave inverter',850000 ,36 ,1000 ,'elerheto')


INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('SolarEdge SE inverter',690000 ,33 ,1000 ,'elerheto')


INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('Tartószerkezet rozsdamentes acél',20000 ,10 ,1000 ,'elerheto')


INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('Tartószerkezet alumínium',30000 ,6 ,1000 ,'elerheto')


INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('Szolár kábel',30000 ,4 ,1000 ,'elerheto')


INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('Tuti Nap biztonsági berendezés',70000 ,5 ,1000 ,'elerheto')

--Utolsó insert megint majd törlés
INSERT INTO Alkatresz(elem_nev,elem_ar,meret,keszlet,alkatresz_allapot)
VALUES('Tuti Nap biztonsági berendezés',70000 ,5 ,1000 ,'elerheto')

--megkapta 17-es elem_id-t, törlés:
DELETE FROM Alkatresz
WHERE elem_nev = 'Tuti Nap biztonsági berendezés'

--eredmény: (2 rows affected), 15-ös id az utolsó, visszainsert
--visszainsert eredmény: 18-as id-t kapta

-------------Alkatrész insertek vége---------------------az alkatrészek vagy elérhtő állapottal rendelkeznek vagy nem elérhető-vel

-------------Megrendelés insertek eleje------------------------

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(1, 9,800,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(2, 7,7,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(3, 1100,1100,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(10, 11,1100,1)


------------Megrendelés insertek vége--------------------
----Insert eredmények:
/*megrendeles_id	elem_id	elem_db	szukseges_keszlet	elofoglalt_keszlet	szabad_keszlet	foglalt	lefoglalando_keszlet
		1				1		9		800				390					NULL				1				410
		2				2		7		7				0					NULL				1				7
		3				3		1100	1100			100					NULL				1				1000  
		
		ha foglalt IGAZ akkor is tökéletesen lefut az else ág*/

--Delete from Megrendelés

DELETE FROM Megrendeles
WHERE megrendeles_id = 4

--Delete eredmény: 
/*
megrendeles_id	elem_id	elem_db	szukseges_keszlet	elofoglalt_keszlet	szabad_keszlet	foglalt	lefoglalando_keszlet
	1				1		9			800				390					NULL			1		410
	3				3		1100		1100			100					NULL			1		1000
*/

-----------------Raktár insert eleje--------------------
INSERT INTO Raktar(elem_id,sor,oszlop,szint,rekesz_meret)
VALUES(6, 1,1,1, 500)

INSERT INTO Raktar(elem_id,sor,oszlop,szint,rekesz_meret)
VALUES(6, 4,3,6, 500)

INSERT INTO Raktar(elem_id,sor,oszlop,szint,rekesz_meret)
VALUES(18, 9,5,2, 900)

INSERT INTO Raktar(elem_id,sor,oszlop,szint,rekesz_meret) --NEM létező elem_id insert teszt, eredmény:
/*The INSERT statement conflicted with the FOREIGN KEY constraint
"FK__Raktar__elem_id__2EDAF651". The conflict occurred in database "DotNetAppSqlDb_db", table "dbo.Alkatresz", column 'elem_id'.
The statement has been terminated.*/
VALUES(26, 5,5,5, 500)

---------------Raktár insert vége-------------------------

---------------Projekt insert eleje-----------------------

INSERT INTO Projekt (allapot, megrendeles_id) /*1. New: a projekt létrehozásra került, de még nem történt meg a helyszíni felmérés.
												2. Draft: a helyszíni felmérés folyamatban van, a terv még nem került véglegesítésre.
												3. Wait: a helyszíni felmérés megtörtént, de az árkalkulációt nem lehetett befejezni, mert volt
														olyan alkatrész, amely nincs a raktárban, így az ára nem ismert.
												4. Scheduled: árkalkuláció elkészült, a projekt a megvalósításra várakozik.
												5. InProgress: a projekt megvalósítása megkezdődött, amelynek első lépése az alkatrészek
																raktárból való kivételezése.
												6. Completed: a projekt sikeresen megvalósult.
												7. Failed: a projekt megvalósítása nem sikerült
												*/
VALUES ('New', 3)

INSERT INTO Projekt(allapot,megrendeles_id)
VALUES ('oLD', 1) --SIKERESEN nem engedi a constraint

UPDATE Projekt
SET allapot = 'Failed'
WHERE megrendeles_id = 3

INSERT INTO Projekt(allapot,megrendeles_id)
VALUES ('New',8)

--Before update:
--projekt_id	allapot	megrendeles_id	datum		osszeg
--1				New		3				2023-03-24	NULL

--After update:
--projekt_id	allapot	megrendeles_id	datum		osszeg
--1				Failed	3				2023-03-24	NULL


select * from Megrendeles

select * from Alkatresz

select * from Raktar

select * from Projekt



go
create trigger tr_ins_megr on Megrendeles after insert as
begin
    declare @foglalt int
    select @foglalt=foglalt from inserted

    if ( @foglalt = 1)
    begin
        declare @szuk_kesz int
        declare @megr_id int
        declare @alkatresz_id int
        declare @szabad_kesz int
        select @megr_id=megrendeles_id from inserted
        select @szuk_kesz=szukseges_keszlet from inserted
        select @alkatresz_id=elem_id from inserted
        select @szabad_kesz=keszlet from Alkatresz where elem_id=@alkatresz_id
        if (@szabad_kesz-@szuk_kesz<0)
            begin
                update Megrendeles
                    set lefoglalando_keszlet = @szabad_kesz
                    where megrendeles_id = @megr_id
                update Megrendeles
                    set elofoglalt_keszlet  = (@szabad_kesz-@szuk_kesz)*(-1)
                    where megrendeles_id = @megr_id
                update Alkatresz
                    set lefoglalt_keszlet = lefoglalt_keszlet + ((@szabad_kesz-@szuk_kesz)*(-1))
                    where elem_id = @alkatresz_id
            end
        else
            begin
                update Megrendeles
                    set lefoglalando_keszlet = @szuk_kesz
                    where megrendeles_id = @megr_id
                update Megrendeles
                    set elofoglalt_keszlet  = 0
                    where megrendeles_id = @megr_id
            end
        update Alkatresz
            set keszlet  = keszlet-@szuk_kesz
            where elem_id = @alkatresz_id
    end
end
go

--drop trigger tr_ins_projekt_osszeg

GO
CREATE TRIGGER tr_ins_projekt_osszeg ON Projekt AFTER INSERT AS
BEGIN
	DECLARE @osszeg INT = 0
	
	IF(@osszeg = 0)
	BEGIN
		DECLARE @db INT
		DECLARE @ar INT
		DECLARE @megrendelesid INT
		DECLARE @elemid INT
		SELECT @megrendelesid = megrendeles_id FROM inserted
		SELECT @elemid = elem_id FROM Megrendeles WHERE megrendeles_id = @megrendelesid
		SELECT @ar = elem_ar FROM Alkatresz WHERE elem_id = @elemid
		SELECT @db = szukseges_keszlet FROM Megrendeles WHERE elem_id = @elemid
		SELECT @osszeg = @db*@ar
		UPDATE Projekt
			SET osszeg = @osszeg
			WHERE megrendeles_id = @megrendelesid
		
	END
	print @megrendelesid
		print @elemid
		print @osszeg
END
GO


--Megrendeles tábla magyarázat:
--elem_db: a már a megrendeléshez hozzáadott
--szabad_keszlet: amennyi van az alkatrész táblában elérhető
--szukseges_keszlet: amennyi kell összesen

--TODO: megrendelés feltöltés: Done, de lehetne még
--projekt feltöltés: Done
--raktár hiányzó adatok feltöltés: Done, de lehetne még
--nullos mezők kiszedése: Done
--Constraintek naprakésszé tétele: Done

UPDATE Alkatresz
SET alkatresz_allapot = 'elerheto'
WHERE alkatresz_allapot IS NULL

----------------Megrendeles insert 2.0 eleje--------------------------------
--létező elem_id-k: 4-14, 18, 22, 23, 25-28

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(8, 1,120,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(9, 21,200,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(11, 5,50,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(12, 31,70,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(13, 16,88,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(14, 2,100,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 40,11,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(22, 21,12,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(23, 0,90,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(25, 1,91,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(26, 11,49,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(27, 9,9,1)


INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(12, 3,7,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(13, 1,8,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(14, 2,10,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 4,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(22, 28,12,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(23, 9,9,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(25, 1,9,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(26, 1,9,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(27, 9,9,1)
----------------Megrendeles insert 2.0 vége---------------------------------

----------------Projekt insert eleje----------------------------------------
INSERT INTO Projekt(allapot,megrendeles_id)
VALUES ('InProgress', 13)

INSERT INTO Projekt(allapot,megrendeles_id)
VALUES ('Failed', 15)

INSERT INTO Projekt(allapot,megrendeles_id)
VALUES ('Completed', 21)

INSERT INTO Projekt(allapot,megrendeles_id)
VALUES ('Draft', 18)

INSERT INTO Projekt(allapot,megrendeles_id)
VALUES ('Wait', 17)

INSERT INTO Projekt(allapot,megrendeles_id)
VALUES ('Scheduled', 26)

INSERT INTO Projekt(allapot,megrendeles_id)
VALUES ('Completed', 25)

INSERT INTO Projekt(allapot,megrendeles_id)
VALUES ('InProgress', 5)
----------------Projekt insert vége-----------------------------------------

----------------Raktár update és insert eleje-------------------------------
/*rekesz_id	elem_id	sor	oszlop	szint	rekesz_meret	tartalmaz_db
1			6		1	1		1		500				NULL
2			6		4	3		6		500				NULL
3			18		9	5		2		900				NULL
5			6		2	1		1		9864			NULL
6			4		2	2		1		10500			NULL
7			5		2	2		2		330000			NULL*/

update Raktar
SET tartalmaz_db = 13
WHERE rekesz_id = 1


update Raktar
SET tartalmaz_db = 13
WHERE rekesz_id = 2


update Raktar
SET tartalmaz_db = 180
WHERE rekesz_id = 3


update Raktar
SET tartalmaz_db = 274
WHERE rekesz_id = 5


update Raktar
SET tartalmaz_db = 500
WHERE rekesz_id = 6


update Raktar
SET tartalmaz_db = 10000
WHERE rekesz_id = 7

/*
rekesz_id	elem_id	sor	oszlop	szint	rekesz_meret	tartalmaz_db
1			6		1	1		1		500				13
2			6		4	3		6		500				13
3			18		9	5		2		900				180
5			6		2	1		1		9864			274
6			4		2	2		1		10500			500
7			5		2	2		2		330000			10000
 matek stimmel*/

 INSERT INTO Raktar(elem_id,sor,oszlop,szint,rekesz_meret,tartalmaz_db)
VALUES(11, 3,3,3, 1000,27)

INSERT INTO Raktar(elem_id,sor,oszlop,szint,rekesz_meret,tartalmaz_db)
VALUES(8, 4,4,4, 2000,60)

INSERT INTO Raktar(elem_id,sor,oszlop,szint,rekesz_meret,tartalmaz_db)
VALUES(14, 5,5,5, 3000,500)

INSERT INTO Raktar(elem_id,sor,oszlop,szint,rekesz_meret,tartalmaz_db)
VALUES(25, 6,6,6, 4000,190)

INSERT INTO Raktar(elem_id,sor,oszlop,szint,rekesz_meret,tartalmaz_db)
VALUES(26, 7,7,7, 5000,250)

INSERT INTO Raktar(elem_id,sor,oszlop,szint,rekesz_meret,tartalmaz_db)
VALUES(27, 8,8,8, 6000,300)

INSERT INTO Raktar(elem_id,sor,oszlop,szint,rekesz_meret,tartalmaz_db)
VALUES(12, 9,9,9, 7000,212)


----------------Raktár update és insert vége-------------------------------