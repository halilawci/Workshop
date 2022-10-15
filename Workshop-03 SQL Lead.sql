-- -WRITE A QUERY THAT RETURNS TRACK NAME AND ITS COMPOSER FROM TRACKS TABLE

SELECT Composer,Name from tracks

---WRITE A QUERY THAT RETURNS ALL COLUMNS FROM TRACKS TABLE

SELECT * from tracks 




---WRITE A QUERY THAT RETURNS THE NAME OF COMPOSERS OF EACH TRACK
---(her parçayı beğenenlerin adını döndüren) muhtemelen yanlış.

SELECT Name from tracks

---WRITE A QUERY THAT RETURNS UNIQUE ALBUMID, MEDIATYPEID FROM TRACKS TABLE

SELECT DISTINCT AlbumId, MediaTypeId from tracks

---WRITE A QUERY THAT RETURNS TRACK NAME AND TRACKID OF ‘Jorge Ben’  

SELECT name,TrackId,Composer FROM tracks where Composer = ('Jorge Ben')

---WRITE A QUERY THAT RETURNS ALL INFO OF THE INVOICES OF WHICH TOTAL AMOUNT IS GREATER THAN $25

SELECT * from invoices where total > 25
SELECT * from invoices order by total DESC --- test

---WRITE A QUERY THAT RETURNS ALL INFO OF THE INVOICES OF WHICH TOTAL AMOUNT IS LESS THAN $15. JUST RETURN 5 ROWS  <

SELECT * from invoices where total < 15 limit 5

---WRITE A QUERY THAT RETURNS ALL INFO OF THE INVOICES OF WHICH --- birleşik

SELECT * from invoices A inner join invoice_items B on B.InvoiceId=A.InvoiceId

--- inner join ile olmayan tüm veriler getiriliyor     

---TOTAL AMOUNT IS GREATER THAN $10. THEN SORT THE TOTAL AMOUNTS IN DESCENDING ORDER, LASTLY DISPLAY TOP 2 ROWS --- birleşik

SELECT * from invoices A inner join invoice_items B on B.InvoiceId=A.InvoiceId where total > 10 order by total DESC limit 2

---WRITE A QUERY THAT RETURNS ALL INFO OF THE INVOICES OF WHICH BILLING COUNTRY IS NOT CANADA. 
---THEN SORT THE TOTAL AMOUNTS IN ASCENDING ORDER, LASTLY DISPLAY TOP 10 ROWS

SELECT * from invoices A inner join invoice_items B on B.InvoiceId=A.InvoiceId where BillingCountry is not 'Canada' order by total ASC limit 10;
SELECT * from invoices A inner join invoice_items B on B.InvoiceId=A.InvoiceId where BillingCountry != 'Canada' order by total ASC limit 10;

---WRITE A QUERY THAT RETURNS INVOICEID, CUSTOMERID AND TOTAL DOLLAR AMOUNT FOR EACH INVOICE. 
--THEN SORT THEM FIRST BY CUSTOMERID IN ASCENDING, THEN TOTAL DOLLAR AMOUNT IN DESCENDING ORDER.

SELECT A.InvoiceId,A.CustomerId,A.total from invoices A inner join invoice_items B on B.InvoiceId=A.InvoiceId order by  total DESC; -- total veri
SELECT InvoiceId,CustomerId,total from invoices order by total DESC; --- 412 veri


SELECT InvoiceId,CustomerId,total 
from invoices 
order by CustomerId ASC, total DESC---412 veri


--- WRITE A QUERY THAT RETURNS ALL TRACK NAMES THAT START WITH ‘B’AND END WITH ‘S’

SELECT * FROM tracks where name like 'B%N' ;
SELECT * FROM tracks where name like 'B%' ;

-- FOR LİKE
-- - **Percent (%):** The `%` character matches any sequence of zero or more characters.
-- *Underscore ( _ ):** The `_` character matches any single character.
-- - 'Out%' pattern matches any string beginning with "Out" such as "Outro".
-- - outla başlayanları bulmak için
-- s%' pattern matches any string that starts with "s" such as "silk", "soup", etc.
-- - S ile başlayanları bulmak için
-- %per%' pattern matches any string containing "per" such as "percentile" and "peeper".
-- - Tamamen kelimelerin arasında veya herhangi bir yerinde arama yapmak için
-- 's_n' pattern matches "son", "sun", etc.
-- - s ile başlayp n ile bitenler
--  '__te' pattern matches "mate", "Kate", "kate", etc.

---WRITE A QUERY THAT RETURNS THE NEWEST DATE AMONG THE INVOICE DATES BETWEEN 2008 AND 2011

SELECT * from invoices where InvoiceDate BETWEEN '2008-01-01' and '2011-12-30' order by InvoiceDate DESC 
SELECT * from invoices where InvoiceDate BETWEEN '2008' and '2011'

--- WRITE A QUERY THAT RETURNS THE FIRST AND LAST NAME OF THE CUSTOMERS WHO HAVE ORDERS FROM NORWAY AND BELGIUM.

SELECT FirstName,LastName FROM customers WHERE Country in ('Norway','Belgium')
SELECT FirstName,LastName FROM customers WHERE Country = ('Norway','Belgium')  --**
SELECT FirstName, LastName from customers INNER JOIN invoices ON customers.CustomerId= invoices.CustomerId
where invoices.BillingCountry IN ("Norway", "Belgium")

---WRITE A QUERY THAT RETURNS THE TRACK NAMES OF ‘ZAPPA’

SELECT * from tracks where Composer like '%ZAPPA%'

---HOW MANY TRACKS AND INVOICES ARE THERE IN THE DIGITAL MUSIC STORE, DISPLAY SEPERATELY --- Yanlış

SELECT count(TrackId) from tracks --- ilkel first.
SELECT Count(InvoiceId) from invoices --- ilkel sec.
SELECT count(TrackId) from tracks where TrackId is not NULL ---not null opt.
SELECT count(TrackId) from tracks where InvoiceId (SELECT count(InvoiceId) from invoices)---- Bu metod yanlış
SELECT count(DISTINCT TrackId) as track_count, count(DISTINCT InvoiceId) as invoice_count FROM tracks, invoices --- bu muhtemelen doğru
SELECT count(A.TrackId),count(B.InvoiceId) from tracks A 
inner join invoice_items C on C.InvoiceLineId=A.InvoiceId
inner join invoices B on B.InvoiceId+A.TrackId  --- absurd

SELECT count(A.TrackId),count(B.InvoiceId) from tracks A inner join invoices B on B.InvoiceId=A.TrackId   -- just try
SELECT count(A.TrackId),count(B.InvoiceId) from tracks A left join invoices B on B.InvoiceId and A.TrackId  --- just try


---HOW MANY COMPOSERS ARE THERE IN THE DIGITAL MUSIC STORE

SELECT count(DISTINCT(Composer)) from tracks
SELECT count(DISTINCT(Composer)) from tracks where Composer is not null
SELECT count(DISTINCT(A.Composer)),count(DISTINCT(B.Title)) from tracks A  inner join albums B on A.AlbumId=B.AlbumId

select count(DISTINCT Composer) from tracks
select count(DISTINCT Composer) from tracks where Composer is not NULL

select count(Composer) from tracks
select count(Composer) from tracks where Composer is not NULL


---HOW MANY TRACKS DOES EACH ALBUM HAVE, DISPLAY ALBUMID AND NUMBER OF TRACKS SORTED FROM HIGHEST TO LOWEST

SELECT A.Title,B.name from albums A left join tracks B on B.AlbumId=A.AlbumId 
SELECT count(DISTINCT TrackId), count(DISTINCT InvoiceId) FROM tracks, invoices

---WRITE A QUERY THAT RETURNS TRACK NAME HAVING THE MINIMUM AND MAXIMUM DURATION, DISPLAY SEPERATELY

SELECT Name,min(Milliseconds),max(Milliseconds) from tracks group by Milliseconds

---WRITE A QUERY THAT RETURNS THE TRACKS HAVING DURATION LESS THAN THE AVERAGE DURATION

SELECT avg(Milliseconds) from tracks ---
SELECT * from tracks where Milliseconds < 393599 order by Milliseconds DESC

SELECT TrackId, name, Milliseconds FROM tracks
WHERE Milliseconds <
(	SELECT avg(Milliseconds)
	FROM tracks
	) order by Milliseconds DESC

---WRITE A QUERY THAT RETURNS THE TOTAL NUMBER OF EACH COMPOSER’s TRACK.
---her bir composerin kaç şarkısı var

SELECT composer, count(TrackId) as Total_Num FROM tracks GROUP BY Composer --- Doğru cevap


SELECT composer, sum(TrackId) as Total_Num FROM tracks GROUP BY Composer 
SELECT composer, sum(TrackId) as Total_Num FROM tracks GROUP BY Composer order by Total_Num DESC

---WRITE A QUERY THAT RETURNS THE GENRE OF EACH TRACK.
--- having grup by dan sonra kullanılır; ortalama veya toplam değerlerinin gösterimi için...


SELECT tracks.name,tracks.GenreId,genres.name from tracks 
inner join genres on tracks.GenreId = genres.GenreId


SELECT tracks.AlbumId, albums.Title, sum(Milliseconds) from tracks 
INNER JOIN albums on albums.AlbumId = tracks.AlbumId  
GROUP BY albums.Title HAVING sum(Milliseconds) > 4200000  
ORDER by sum(tracks.Milliseconds) DESC



---WRITE A QUERY THAT RETURNS THE ARTIST’s ALBUM INFO.
---SANATÇININ ALBÜM BİLGİLERİNİ DÖNDÜREN BİR SORU YAZIN.
SELECT * from tracks A inner join albums B on A.AlbumId=B.AlbumId inner join artists C on c.ArtistId=B.ArtistId 
SELECT * from tracks A inner join albums B on A.AlbumId=B.AlbumId inner join artists C on c.ArtistId=B.ArtistId  
inner join playlist_track D on D.TrackId=A.TrackId

SELECT artists.name,albums.AlbumId From albums inner join artists  on albums.ArtistId=artists.ArtistId---- doğru

---WRITE A QUERY THAT RETURNS THE MINIMUM DURATION OF THE TRACKIN EACH ALBUM. 
---DISPLAY ALBUMID, ALBUM TITLE AND DURATION OF THETRACK. THEN SORT THEM FROM HIGHEST TO LOWEST
---HER ALBÜMDEKİ MİNİMUM PARÇA SÜRESİNİ DÖNDÜREN BİR SORU YAZIN. ALBÜMID'İ, ALBÜM İSMİ VE PARÇA SÜRESİ'Nİ GÖRÜNTÜLEYİN. SONRA EN YÜKSEKTEN DÜŞÜĞE DÖNÜŞTÜRÜN

SELECT tracks.AlbumId, albums.Title, min(Milliseconds) from tracks 
INNER JOIN albums on albums.AlbumId = tracks.AlbumId  
GROUP BY albums.Title HAVING min(Milliseconds) 
ORDER by min(tracks.Milliseconds) DESC


SELECT B.AlbumId ,B.Title,min(Milliseconds),A.name
from tracks A inner join albums B on A.AlbumId=B.AlbumId
GROUP by B.AlbumId order by Milliseconds DESC limit 1

---WRITE A QUERY THAT RETURNS ALBUMS WHOSE TOTAL DURATION IS HIGHER THAN 60 MIN. 
---DISPLAY ALBUM TITLE AND THEIR DURATIONS. THEN SORT THE RESULT FROM HIGHEST TO LOWEST
---TOPLAM SÜRESİ 60 DAKİKADAN UZAK OLAN ALBÜMLERİ DÖNDÜREN BİR SORU YAZIN. ALBÜM İSMİ VE SÜRELERİNİ GÖRÜNTÜLEYİN. SONRA SONUCU EN YÜKSEKTEN DÜŞÜĞE DÜZENLE
---- 60 DK = 3600000 ms.

SELECT * from tracks A
INNER JOIN albums B on B.AlbumId = A.AlbumId  
where A.Milliseconds > '3600000'
ORDER by A.Milliseconds DESC



---WRITE A QUERY THAT RETURNS TRACKID, TRACK NAME AND ALBUMIDINFO OF THE ALBUM WHOSE TITLE ARE ‘Prenda Minha’, 'Heart of the Night'AND 'Out Of Exile'.


SELECT * from tracks A inner join albums B on A.AlbumId=B.AlbumId inner join artists C on c.ArtistId=B.ArtistId 
where B.Title in ('Prenda Minha','Heart of the Night','Out Of Exile')


SELECT A.TrackId,A.name,B.AlbumId,B.Title from tracks A inner join albums B on A.AlbumId=B.AlbumId inner join artists  
where B.Title in ('Prenda Minha','Heart of the Night','Out Of Exile')---- doğru sonuç

