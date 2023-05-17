

--egyszerre egy insert futtatása elemenként a Megrendelés táblánál



					--INSERT only (projekt_id, allapot, megrendeles_id)
					select * from Projekt
		
CREATE TABLE Projekt(
					projekt_tabla_id INT IDENTITY PRIMARY KEY,
					projekt_id INT,
					
					allapot VARCHAR(40) CHECK (allapot IN('New', 'Draft', 'Wait', 'Scheduled', 'InProgress','Completed','Failed')),
					megrendeles_id INT REFERENCES Megrendeles ON UPDATE CASCADE ON DELETE CASCADE,
					datum DATE DEFAULT(GETDATE()),
					osszeg INT)


					update projekt
					set allapot = 'New'
					where projekt_id = 3
					
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

INSERT INTO Projekt (projekt_id ,allapot, megrendeles_id) /*1. New: a projekt létrehozásra került, de még nem történt meg a helyszíni felmérés.
												2. Draft: a helyszíni felmérés folyamatban van, a terv még nem került véglegesítésre.
												3. Wait: a helyszíni felmérés megtörtént, de az árkalkulációt nem lehetett befejezni, mert volt
														olyan alkatrész, amely nincs a raktárban, így az ára nem ismert.
												4. Scheduled: árkalkuláció elkészült, a projekt a megvalósításra várakozik.
												5. InProgress: a projekt megvalósítása megkezdődött, amelynek első lépése az alkatrészek
																raktárból való kivételezése.
												6. Completed: a projekt sikeresen megvalósult.
												7. Failed: a projekt megvalósítása nem sikerült
												*/
VALUES (1,'New', 5)

INSERT INTO Projekt(allapot,megrendeles_id)
VALUES ('oLD', 1) --SIKERESEN nem engedi a constraint

UPDATE Projekt
SET allapot = 'New'
WHERE megrendeles_id = 6

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (1,'New',8)

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
INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (2,'InProgress', 13)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (4,'Failed', 15)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (3,'Completed', 21)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (5,'Draft', 18)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (6,'Wait', 17)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (7,'Scheduled', 26)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (3,'Completed', 25)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (2,'InProgress', 5)
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

----------------Új megrendelések eleje-------------------------------------

select * from alkatresz
INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(5, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(4, 0,10,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(14, 0,10,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 0,1,1)
----------------------------------------------------------------------------

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(7, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(25, 0,10,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(13, 0,10,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 0,1,1)
---------------------------------------------------------------------------

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(14, 0,100,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(27, 0,100,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(8, 0,2,1)
---------------------------------------------------------------------------

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(26, 0,20,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(14, 0,20,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(9, 0,1,1)
----------------------------------------------------------------------------

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(11, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(25, 0,10,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(13, 0,10,1)
----------------------------------------------------------------------------

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 0,2,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(6, 0,3,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(13, 0,100,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(27, 0,100,1)
----------------------------------------------------------------------------

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(8, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(14, 0,10,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(26, 0,10,1)
----------------------------------------------------------------------------

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(25, 0,10,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(6, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(13, 0,10,1)
----------------------------------------------------------------------------

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(26, 0,10,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(5, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(13, 0,10,1)
----------------------------------------------------------------------------

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(27, 0,10,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(9, 0,1,1)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(13, 0,10,1)
----------------Új megrendelések vége---------------------------------------

----------------Új projektek eleje------------------------------------------
select * from Megrendeles
-- 27, 28, 29, 30

select * from Projekt

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (8,'New', 27)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (8,'New', 28)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (8,'New', 29)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (8,'New', 30)

----------------------------------------------------------------------------
-- 31, 32, 33, 34

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (9,'New', 31)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (9,'New', 32)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (9,'New', 33)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (9,'New', 34)
----------------------------------------------------------------------------
-- 35, 36, 37, 38

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (10,'New', 35)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (10,'New', 36)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (10,'New', 37)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (10,'New', 38)
----------------------------------------------------------------------------
-- 39, 40, 41, 42

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (11,'New', 39)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (11,'New', 40)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (11,'New', 41)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (11,'New', 42)
----------------------------------------------------------------------------
-- 43, 44, 45, 46

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (12,'New', 43)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (12,'New', 44)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (12,'New', 45)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (12,'New', 46)
----------------------------------------------------------------------------
-- 47, 48, 49, 50
update Projekt
set projekt_id = 13
where megrendeles_id in(48,49,50)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (13,'New', 47)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (13,'New', 48)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (13,'New', 49)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (13,'New', 50)
----------------------------------------------------------------------------
-- 51, 52, 53, 54

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (14,'New', 51)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (14,'New', 52)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (14,'New', 53)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (14,'New', 54)
----------------------------------------------------------------------------
-- 55, 56, 57, 58

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (15,'InProgress', 55)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (15,'InProgress', 56)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (15,'InProgress', 57)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (15,'InProgress', 58)

----------------------------------------------------------------------------
-- 59, 60, 61, 62

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (16,'InProgress', 59)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (16,'InProgress', 60)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (16,'InProgress', 61)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (16,'InProgress', 62)
----------------------------------------------------------------------------
-- 63, 64, 65, 66

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (17,'InProgress', 63)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (17,'InProgress', 64)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (17,'InProgress', 65)

INSERT INTO Projekt(projekt_id,allapot,megrendeles_id)
VALUES (17,'InProgress', 66)
----------------Új projektek vége-------------------------------------------

select * from Alkatresz

----------------Új megrendelések eleje--------------------------------------

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(5, 0,1,0)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(4, 0,10,0)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(14, 0,10,0)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 0,1,0)
----------------------------------------------------------------------------

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(7, 0,1,0)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(25, 0,10,0)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(13, 0,10,0)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 0,1,0)
---------------------------------------------------------------------------

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(18, 0,1,0)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(14, 0,100,0)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(27, 0,100,0)

INSERT INTO Megrendeles(elem_id, elem_db,szukseges_keszlet, foglalt )
VALUES(8, 0,2,0)
----------------Megrendelések vége------------------------------------------


select * from megrendeles

update Megrendeles
set lefoglalando_keszlet = 0
where lefoglalando_keszlet is null


update Megrendeles
set szabad_keszlet = 0
where szabad_keszlet is null


update Megrendeles
set elofoglalt_keszlet = 0
where elofoglalt_keszlet is null