-- 1-	Which customers use our services more frequent
SELECT TOP 20
	FName + ' ' + LName AS Customer_Name
	,COUNT(r.Reservation_ID) AS Numder_Of_Servicee

FROM Customer c, Reservations_ r
WHERE c.Customer_ID = r.Customer_ID
GROUP BY FName + ' ' + LName
ORDER BY Numder_Of_Servicee DESC;

---------------------------------------------------------------------------------------------
-- 2-	What are the most popular flight routes/Timings/airports/aircrafts.
Alter Table Route
ADD Route_Name VARCHAR(20);


UPDATE Route SET
Route_Name = SourceCity + ' - ' + SrcCountry + ' => ' + DestCity + ' - ' + DestCountry;


SELECT TOP(5)
	Route_Name 
	,COUNT(*) Number_Of_Routes
	
FROM 
	Flight f, Bridge_Flight_ b, Route r
WHERE 
	F.ID = B.Flight_ID
	AND R.Route_ID = B.Route_ID
GROUP BY Route_Name 
ORDER BY Number_Of_Routes DESC;


--------------------------------------------------------------
SELECT TOP(5)
	a.Model
	,COUNT(*) Number_Of_Models
	
FROM 
	Flight f, Bridge_Flight_ b, Aircraft a
WHERE 
	f.ID = f.Flight_ID
	AND b.Aircraft_ID = a.Aircraft_ID
GROUP BY a.Model
ORDER BY Number_Of_Models DESC;

----------------------------------------------------------------------------------
-- 4-	Which customers contribute the most to our revenue.
SELECT TOP 10
	FName + ' ' + LName AS Customer_Name
	,SUM(r.Price_) AS Revenue

FROM Customer c, Reservations_ r
WHERE c.Customer_ID = r.Customer_ID
GROUP BY FName + ' ' + LName
ORDER BY Revenue DESC;
------------------------------------------------------------------------------------
-- 5- What are the main sources of revenue for the company


--------------------------------------------------------------------------------------
-- 7- Which customer rank (gold, platinum, titanium) are most profitable to us.
SELECT TOP 10
	Status
	,SUM(r.Price_) AS Revenue

FROM Customer c, Reservations_ r
WHERE c.Customer_ID = r.Customer_ID

GROUP BY Status
ORDER BY Revenue DESC;

-----------------------------------------------------------------------------------------------
-- 8-	Which booking channel is most rewarding.
--      Which booking channel-PAYMENT/FARE BASIS is most rewarding/popular.

SELECT        -- Which booking channel is most rewarding
	c.Name Channel
	,SUM(r.Price_) Revenue

FROM Channel_ c , Reservations_ r
where c.Channel_ID = r.Channel_ID
GROUP BY Name
ORDER BY Revenue DESC;
----
SELECT        -- Which booking channel is most popular
	c.Name Channel
	,COUNT(*) Number_Of_Channels

FROM Channel_ c , Reservations_ r
where c.Channel_ID = r.Channel_ID
GROUP BY c.Name
ORDER BY  Number_Of_Channels DESC;

-----------
SELECT                   -- Which PAYMENT is most rewarding
	pm.Name PAYMENT
	,SUM(r.Price_) Revenue

FROM Payment_Method pm , Reservations_ r
where pm.PM_ID = r.PM_ID
GROUP BY Name
ORDER BY Revenue DESC;
------
SELECT                   -- Which PAYMENT is most popular
	pm.Name PAYMENT
	,COUNT(*) Number_Of_PAYMENT

FROM Payment_Method pm , Reservations_ r
where pm.PM_ID = r.PM_ID
GROUP BY Name
ORDER BY Number_Of_PAYMENT DESC;

---------------
SELECT                   -- Which FARE BASIS is most rewarding
	fc.Name
	,SUM(r.Price_) Revenue

FROM Fare_Basis_Class fc , Reservations_ r
where fc.FBC_ID = r.FBC_ID
GROUP BY fc.Name
ORDER BY Revenue DESC; 
-------
SELECT                   -- Which FARE BASIS is most popular
	fc.Name FARE_BASIS
	,COUNT(*) Number_Of_FARE_BASIS

FROM Fare_Basis_Class fc , Reservations_ r
where fc.FBC_ID = r.FBC_ID
GROUP BY fc.Name
ORDER BY Number_Of_FARE_BASIS DESC; 
-----------------------------------------------
-- 9-	What are the aspects that we need to improve to achieve better customer satisfaction.
SELECT TOP 5
	pm.Name payment
	,COUNT(*) FREQ
	,SUM(Severity_) SEV
FROM Customer_Services c
	,Payment_Method pm
	,ACTION a
WHERE c.ACTION_ID = a.ACTION_ID 
	AND c.PM_ID = pm.PM_ID
	AND a.Type = 'Complaint'
GROUP BY pm.Name
ORDER BY FREQ DESC;
------
SELECT TOP 5
	c.Name Channel
	,COUNT(*) FREQ
	,SUM(Severity_) SEV
FROM Customer_Services cs
	,Channel_ c
	,ACTION a
WHERE cs.ACTION_ID = a.ACTION_ID 
	AND cs.Channel_ID = c.Channel_ID
	AND a.Type = 'Complaint'
GROUP BY c.Name
ORDER BY FREQ DESC;
----------
SELECT TOP 5
	c.FName + ' ' + c.LNname + ' - ' + c.Position Member
	,COUNT(*) FREQ
	,SUM(Severity_) SEV
FROM Customer_Services cs
	,Crew_Member c
	,ACTION a
WHERE cs.ACTION_ID = a.ACTION_ID 
	AND cs.Member_ID = c.Member_ID
	AND a.Type = 'Complaint'
GROUP BY c.FName + ' ' + c.LNname + ' - ' + c.Position
ORDER BY FREQ DESC;
-----------------------------------------------
-- 10-	Which flights receive the best/worst customer feedback.
SELECT top 1 --best
	FLIGHT_ID
	,COUNT(*)  FEEDBACK
	,SUM(cs.Severity_) SEV
FROM Customer_Services cs, Action a
WHERE cs.ACTION_ID = a.ACTION_ID
AND a.TYPE = 'Feedback'
GROUP BY FLIGHT_ID 
ORDER BY SUM(cs.Severity_) desc;

SELECT top 1 --worst
	FLIGHT_ID
	,COUNT(*)  COMPLAINTS
	,SUM(cs.Severity_)  SEV
FROM CUSTOMER_SERVICES CS, Action a
WHERE cs.Action_ID = A.Action_ID
AND A.TYPE = 'Complaint'
GROUP BY FLIGHT_ID 
ORDER BY COUNT(*) DESC;
-----------------------------------------------------
-- 11-	Which crew members are most successful/lovable.
select TOP 5
	m.FName + ' ' + m.LNname  Member
	,COUNT(*) FREQUENCY
FROM  Crew_Member m
	,Flight f
WHERE F.Captain_ID = M.Member_ID
GROUP BY m.FName + ' ' + m.LNname 
ORDER BY COUNT(*) DESC;
---------------------------------------------
-- 14-	How do customer demographics, such as age or income level, impact travel behavior and preferences.
-- How do customer age  impact travel behavior and preferences
CREATE VIEW Age AS 
(
SELECT CASE
		WHEN YEAR(GETDATE()) -  YEAR(CU.DOB) > 50
			THEN 'Old'
		WHEN YEAR(GETDATE()) -  YEAR(CU.DOB) > 30
			THEN 'Grown Up'
		WHEN YEAR(GETDATE()) -  YEAR(CU.DOB) > 18
			THEN 'Youth'
		ELSE  'Kid'
	END AS AGE

	,c.Name as channel
	,A.Name AS AIRPORT
FROM Reservations_ R, Channel_ C , Customer CU, Bridge_Flight_ B, Airport A
WHERE R.Channel_ID = C.Channel_ID
AND R.Customer_ID = CU.Customer_ID
AND B.Flight_ID = R.Flight_ID
AND B.SRCAirport_ID = A.Airport_ID
AND CU.DOB IS NOT NULL);


SELECT
	AGE
	,Channel
	,COUNT(*) AS FREQUENCY
FROM Age
GROUP BY AGE , CHANNEL
ORDER BY AGE, CHANNEL, FREQUENCY DESC;




SELECT *
FROM Age

SELECT *
FROM [dbo].[Action]

SELECT *
FROM  Crew_Member

SELECT *
FROM  Flight f