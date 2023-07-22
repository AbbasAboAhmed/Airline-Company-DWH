CREATE TABLE Aircraft
(
  Aircraft_Id INT NOT NULL PRIMARY KEY
  ,Model VARCHAR(100) NOT NULL
  ,Type VARCHAR(75) NOT NULL
  ,Capacity INT NOT NULL
  ,Manufacturer VARCHAR(100) NOT NULL
  
);

CREATE TABLE Route
(
  Route_ID INT NOT NULL PRIMARY KEY
  ,SourceCity VARCHAR(50) NOT NULL
  ,DestCity VARCHAR(50) NOT NULL
  ,EstDistance INT
  ,SrcCountry VARCHAR(75) NOT NULL
  ,DestCountry VARCHAR(75) NOT NULL
   
);

CREATE TABLE Date
(
  Date_ID INT NOT NULL PRIMARY KEY
  ,Minute INT NOT NULL
  ,Hour INT NOT NULL
  ,Week INT NOT NULL
  ,Month INT NOT NULL
  ,Quarter INT NOT NULL
  ,Year INT NOT NULL
  ,Day INT NOT NULL
   
);

CREATE TABLE Crew_Member
(
  Member_ID INT NOT NULL PRIMARY KEY
  ,FName VARCHAR(50) NOT NULL
  ,LNname VARCHAR(50) NOT NULL
  ,DOB DATE
  ,Gender_ CHAR(1) NOT NULL
  ,City VARCHAR(50)
  ,Country VARCHAR(75)
  ,Email VARCHAR(100)
  ,Position VARCHAR(50) NOT NULL
  ,HireDate DATE NOT NULL
  ,Phone VARCHAR(15) NOT NULL
   
);

CREATE TABLE Airport
(
  Airport_ID INT NOT NULL PRIMARY KEY 
  ,Country VARCHAR(75) NOT NULL
  ,City VARCHAR(50) NOT NULL
  ,Name VARCHAR(49) NOT NULL
  
);

CREATE TABLE Bridge_Flight_
(
  Flight_ID INT NOT NULL PRIMARY KEY 
  ,Aircraft_Id INT NOT NULL
  ,Route_ID INT NOT NULL
  ,SRCAirport_ID INT NOT NULL
  ,DestAirport_ID INT NOT NULL
 
  ,FOREIGN KEY (Aircraft_Id) REFERENCES Aircraft(Aircraft_Id)
  ,FOREIGN KEY (Route_ID) REFERENCES Route(Route_ID)
  ,FOREIGN KEY (SRCAirport_ID) REFERENCES Airport(Airport_ID)
  ,FOREIGN KEY (DestAirport_ID) REFERENCES Airport(Airport_ID)
);

CREATE TABLE Customer
(
  Customer_ID INT NOT NULL PRIMARY KEY
  ,FName VARCHAR(50) NOT NULL
  ,LName VARCHAR(50) NOT NULL
  ,Gender CHAR(1) NOT NULL
  ,City VARCHAR(50)
  ,Country VARCHAR(75)
  ,DOB DATE
  ,Email VARCHAR(100)
  ,Phone VARCHAR(15)
  ,Status VARCHAR(15)
  
);

CREATE TABLE Upgrade
(
  Upgrade_ID INT NOT NULL PRIMARY KEY
  ,Name VARCHAR(50) NOT NULL
  ,Description VARCHAR(256) NOT NULL
  ,StartDate DATE NOT NULL
  ,EndDate DATE NOT NULL
  ,Conditions VARCHAR(256) NOT NULL

);

CREATE TABLE Promotion
(
  Promotion_ID INT NOT NULL PRIMARY KEY
  ,Name VARCHAR(50) NOT NULL
  ,Descrition VARCHAR(256) NOT NULL
  ,StartDate DATE NOT NULL
  ,EndDate DATE NOT NULL
  ,Conditions VARCHAR(256) NOT NULL

);

CREATE TABLE Flyer_Miles
(
  FM_ID INT NOT NULL PRIMARY KEY
  ,miles INT NOT NULL
  ,Description VARCHAR(512) NOT NULL
);

CREATE TABLE Fare_Basis_Class
(
  FBC_ID INT NOT NULL PRIMARY KEY
  ,Name VARCHAR(50) NOT NULL
  ,Description VARCHAR(256) NOT NULL
  ,Privileges VARCHAR(256)
 
);

CREATE TABLE Payment_Method
(
  PM_ID INT NOT NULL PRIMARY KEY
  ,Name VARCHAR(50) NOT NULL
  ,Description VARCHAR(256) NOT NULL
);

CREATE TABLE Channel_
(
  Channel_ID INT NOT NULL PRIMARY KEY
  ,Name VARCHAR(50) NOT NULL
  ,Description VARCHAR(256) NOT NULL
  ,Users INT NOT NULL
  ,Status INT NOT NULL
  
);

CREATE TABLE Action
(
  Action_ID INT NOT NULL PRIMARY KEY
  ,Type VARCHAR(50) NOT NULL
  ,Name VARCHAR(50) NOT NULL
  ,Description VARCHAR(256) NOT NULL
  ,Body VARCHAR(1024) NOT NULL
  
);

CREATE TABLE Flight
(
  NoPassengers INT NOT NULL
  ,EmptySeats INT NOT NULL
  ,CrewCounter INT NOT NULL
  ,Tickets INT NOT NULL
  ,ID INT NOT NULL PRIMARY KEY
  ,Flight_ID INT NOT NULL UNIQUE
  ,Captain_ID INT NOT NULL
  ,Co_Captain_ID INT NOT NULL
  ,Flight__attendant_ID INT NOT NULL
  ,Dep_Date_ID INT NOT NULL
  ,Arr_Date_ID INT NOT NULL
  
  ,FOREIGN KEY (Flight_ID) REFERENCES Bridge_Flight_(Flight_ID)
  ,FOREIGN KEY (Captain_ID) REFERENCES Crew_Member(Member_ID)
  ,FOREIGN KEY (Co_Captain_ID) REFERENCES Crew_Member(Member_ID)
  ,FOREIGN KEY (Flight__attendant_ID) REFERENCES Crew_Member(Member_ID)
  ,FOREIGN KEY (Dep_Date_ID) REFERENCES Date(Date_ID)
  ,FOREIGN KEY (Arr_Date_ID) REFERENCES Date(Date_ID)
  
);


CREATE TABLE Marketing_Analysis
(
  MA_ID INT NOT NULL PRIMARY KEY
  ,Customer_ID INT NOT NULL
  ,Date_ID INT NOT NULL
  ,Flight_ID INT NOT NULL
  ,Upgrade_ID INT NOT NULL
  ,Promotion_ID INT NOT NULL
  ,FM_Obtained_ID INT NOT NULL
  ,FM_Redeemed_ID INT NOT NULL

  ,FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
  ,FOREIGN KEY (Date_ID) REFERENCES Date(Date_ID)
  ,FOREIGN KEY (Flight_ID) REFERENCES Bridge_Flight_(Flight_ID)
  ,FOREIGN KEY (Upgrade_ID) REFERENCES Upgrade(Upgrade_ID)
  ,FOREIGN KEY (Promotion_ID) REFERENCES Promotion(Promotion_ID)
  ,FOREIGN KEY (FM_Obtained_ID) REFERENCES Flyer_Miles(FM_ID)
  ,FOREIGN KEY (FM_Redeemed_ID) REFERENCES Flyer_Miles(FM_ID)
);


SELECT *
FROM Reservations_

CREATE TABLE Reservations_
(
  Reservation_ID INT NOT NULL PRIMARY KEY
  ,BasePrice INT NOT NULL
  ,OvernightStand INT
  ,Discount_ NUMERIC NOT NULL
  ,Price_ INT NOT NULL
  ,Distance INT
  ,SeatNumber int NOT NULL
  ,Customer_ID INT NOT NULL
  ,Flight_ID INT NOT NULL
  ,Date_ID INT NOT NULL
  ,Channel_ID INT NOT NULL
  ,FBC_ID INT NOT NULL
  ,PM_ID INT NOT NULL
 
  ,FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
  ,FOREIGN KEY (Flight_ID) REFERENCES Bridge_Flight_(Flight_ID)
  ,FOREIGN KEY (Date_ID) REFERENCES Date(Date_ID)
  ,FOREIGN KEY (Channel_ID) REFERENCES Channel_(Channel_ID)
  ,FOREIGN KEY (FBC_ID) REFERENCES Fare_Basis_Class(FBC_ID)
  ,FOREIGN KEY (PM_ID) REFERENCES Payment_Method(PM_ID)
);

CREATE TABLE Customer_Services
(
  CS_ID INT NOT NULL PRIMARY KEY
  ,Severity_ INT NOT NULL
  ,Customer_ID INT NOT NULL
  ,Flight_ID INT NOT NULL
  ,PM_ID INT NOT NULL
  ,Channel_ID INT NOT NULL
  ,Member_ID INT NOT NULL
  ,Date_ID INT NOT NULL
  ,Action_ID INT NOT NULL
   
  ,FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
  ,FOREIGN KEY (Flight_ID) REFERENCES Bridge_Flight_(Flight_ID)
  ,FOREIGN KEY (PM_ID) REFERENCES Payment_Method(PM_ID)
  ,FOREIGN KEY (Channel_ID) REFERENCES Channel_(Channel_ID)
  ,FOREIGN KEY (Member_ID) REFERENCES Crew_Member(Member_ID)
  ,FOREIGN KEY (Date_ID) REFERENCES Date(Date_ID)
  ,FOREIGN KEY (Action_ID) REFERENCES Action(Action_ID)
);