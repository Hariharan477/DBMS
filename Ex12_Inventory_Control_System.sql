-- Ex No: 12
-- CASE STUDY: INVENTORY CONTROL SYSTEM (Material Requirement Processing)
-- Real-life database application with tables, queries, updates and deletes

/*=========================================================
   INVENTORY CONTROL SYSTEM MATERIAL REQUIREMENT PROCESSING
=========================================================*/

SET SERVEROUTPUT ON;
SET LINESIZE 120;
SET PAGESIZE 50;


/*=========================================================
   1. DROP OLD TABLES
=========================================================*/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Purchase_Order_Details CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Purchase_Order CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Requirement_Details CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Material_Requirement CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Material CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Department CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Supplier CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


/*=========================================================
   2. CREATE SUPPLIER TABLE
=========================================================*/

CREATE TABLE Supplier (
    Supplier_ID NUMBER PRIMARY KEY,
    Supplier_Name VARCHAR2(50),
    Phone VARCHAR2(15),
    Email VARCHAR2(50)
);


/*=========================================================
   3. CREATE DEPARTMENT TABLE
=========================================================*/

CREATE TABLE Department (
    Department_ID NUMBER PRIMARY KEY,
    Department_Name VARCHAR2(50)
);


/*=========================================================
   4. CREATE MATERIAL TABLE
=========================================================*/

CREATE TABLE Material (
    Material_ID NUMBER PRIMARY KEY,
    Material_Name VARCHAR2(50),
    Category VARCHAR2(30),
    Unit_Price NUMBER(10,2),
    Stock_Quantity NUMBER,
    Reorder_Level NUMBER,
    Supplier_ID NUMBER REFERENCES Supplier(Supplier_ID)
);


/*=========================================================
   5. CREATE MATERIAL REQUIREMENT TABLE
=========================================================*/

CREATE TABLE Material_Requirement (
    Requirement_ID NUMBER PRIMARY KEY,
    Department_ID NUMBER REFERENCES Department(Department_ID),
    Requirement_Date DATE,
    Requirement_Status VARCHAR2(20)
);


/*=========================================================
   6. CREATE REQUIREMENT DETAILS TABLE
=========================================================*/

CREATE TABLE Requirement_Details (
    Requirement_Detail_ID NUMBER PRIMARY KEY,
    Requirement_ID NUMBER REFERENCES Material_Requirement(Requirement_ID),
    Material_ID NUMBER REFERENCES Material(Material_ID),
    Required_Quantity NUMBER
);


/*=========================================================
   7. CREATE PURCHASE ORDER TABLE
=========================================================*/

CREATE TABLE Purchase_Order (
    PO_ID NUMBER PRIMARY KEY,
    Supplier_ID NUMBER REFERENCES Supplier(Supplier_ID),
    PO_Date DATE,
    PO_Status VARCHAR2(20)
);


/*=========================================================
   8. CREATE PURCHASE ORDER DETAILS TABLE
=========================================================*/

CREATE TABLE Purchase_Order_Details (
    PO_Detail_ID NUMBER PRIMARY KEY,
    PO_ID NUMBER REFERENCES Purchase_Order(PO_ID),
    Material_ID NUMBER REFERENCES Material(Material_ID),
    Ordered_Quantity NUMBER,
    Unit_Price NUMBER(10,2)
);


/*=========================================================
   9. INSERT SUPPLIER DATA
=========================================================*/

INSERT INTO Supplier VALUES
(1,'ABC Suppliers','9876543210','abc@gmail.com');

INSERT INTO Supplier VALUES
(2,'XYZ Traders','9876501234','xyz@gmail.com');

INSERT INTO Supplier VALUES
(3,'Global Materials','9876512345','global@gmail.com');


/*=========================================================
   10. INSERT DEPARTMENT DATA
=========================================================*/

INSERT INTO Department VALUES
(1,'Production');

INSERT INTO Department VALUES
(2,'Maintenance');

INSERT INTO Department VALUES
(3,'Electrical');


/*=========================================================
   11. INSERT MATERIAL DATA
=========================================================*/

INSERT INTO Material VALUES
(101,'Steel Rod','Metal',250,80,20,1);

INSERT INTO Material VALUES
(102,'Copper Wire','Electrical',120,15,25,2);

INSERT INTO Material VALUES
(103,'Aluminium Sheet','Metal',180,60,15,3);

INSERT INTO Material VALUES
(104,'PVC Pipe','Plumbing',90,10,20,2);

INSERT INTO Material VALUES
(105,'Rubber Sheet','General',150,45,10,1);


/*=========================================================
   12. INSERT MATERIAL REQUIREMENT DATA
=========================================================*/

INSERT INTO Material_Requirement VALUES
(1001,1,DATE '2026-09-20','Pending');

INSERT INTO Material_Requirement VALUES
(1002,2,DATE '2026-09-21','Approved');

INSERT INTO Material_Requirement VALUES
(1003,3,DATE '2026-09-22','Pending');


/*=========================================================
   13. INSERT REQUIREMENT DETAILS
=========================================================*/

INSERT INTO Requirement_Details VALUES
(1,1001,101,30);

INSERT INTO Requirement_Details VALUES
(2,1001,102,40);

INSERT INTO Requirement_Details VALUES
(3,1002,102,20);

INSERT INTO Requirement_Details VALUES
(4,1002,103,15);

INSERT INTO Requirement_Details VALUES
(5,1003,104,25);

INSERT INTO Requirement_Details VALUES
(6,1003,101,10);


/*=========================================================
   14. INSERT PURCHASE ORDER DATA
=========================================================*/

INSERT INTO Purchase_Order VALUES
(5001,1,DATE '2026-09-23','Pending');

INSERT INTO Purchase_Order VALUES
(5002,2,DATE '2026-09-24','Approved');

INSERT INTO Purchase_Order VALUES
(5003,3,DATE '2026-09-25','Pending');


/*=========================================================
   15. INSERT PURCHASE ORDER DETAILS
=========================================================*/

INSERT INTO Purchase_Order_Details VALUES
(1,5001,101,20,250);

INSERT INTO Purchase_Order_Details VALUES
(2,5001,105,15,150);

INSERT INTO Purchase_Order_Details VALUES
(3,5002,102,50,120);

INSERT INTO Purchase_Order_Details VALUES
(4,5002,104,30,90);

INSERT INTO Purchase_Order_Details VALUES
(5,5003,103,20,180);

COMMIT;


/*=========================================================
   16. DISPLAY ALL MATERIALS
=========================================================*/

SELECT * FROM Material;


/*=========================================================
   17. MATERIALS BELOW REORDER LEVEL
=========================================================*/

SELECT Material_ID, Material_Name, Stock_Quantity, Reorder_Level
FROM Material
WHERE Stock_Quantity < Reorder_Level;


/*=========================================================
   18. MATERIAL AND SUPPLIER DETAILS
=========================================================*/

SELECT m.Material_ID, m.Material_Name, m.Category, s.Supplier_Name
FROM Material m
JOIN Supplier s ON m.Supplier_ID = s.Supplier_ID;


/*=========================================================
   19. TOTAL STOCK VALUE
=========================================================*/

SELECT SUM(Unit_Price * Stock_Quantity) AS Total_Stock_Value
FROM Material;


/*=========================================================
   20. MATERIAL COUNT BY CATEGORY
=========================================================*/

SELECT Category, COUNT(*) AS Number_Of_Materials
FROM Material
GROUP BY Category;


/*=========================================================
   21. REQUIREMENT DETAILS
=========================================================*/

SELECT mr.Requirement_ID, d.Department_Name, mr.Requirement_Date, mr.Requirement_Status
FROM Material_Requirement mr
JOIN Department d ON mr.Department_ID = d.Department_ID;


/*=========================================================
   22. REQUIRED MATERIAL QUANTITIES
=========================================================*/

SELECT m.Material_Name, SUM(rd.Required_Quantity) AS Total_Required_Quantity
FROM Requirement_Details rd
JOIN Material m ON rd.Material_ID = m.Material_ID
GROUP BY m.Material_Name;


/*=========================================================
   23. MOST EXPENSIVE MATERIAL
=========================================================*/

SELECT Material_ID, Material_Name, Unit_Price
FROM Material
WHERE Unit_Price = (SELECT MAX(Unit_Price) FROM Material);


/*=========================================================
   24. PURCHASE ORDER DETAILS
=========================================================*/

SELECT po.PO_ID, s.Supplier_Name, po.PO_Date, po.PO_Status
FROM Purchase_Order po
JOIN Supplier s ON po.Supplier_ID = s.Supplier_ID;


/*=========================================================
   25. PURCHASE ORDER MATERIAL DETAILS
=========================================================*/

SELECT po.PO_ID, s.Supplier_Name, m.Material_Name, pod.Ordered_Quantity, pod.Unit_Price
FROM Purchase_Order_Details pod
JOIN Purchase_Order po ON pod.PO_ID = po.PO_ID
JOIN Supplier s ON po.Supplier_ID = s.Supplier_ID
JOIN Material m ON pod.Material_ID = m.Material_ID;


/*=========================================================
   26. UPDATE STOCK QUANTITY
=========================================================*/

UPDATE Material
SET Stock_Quantity = Stock_Quantity + 20
WHERE Material_ID = 102;

COMMIT;


/*=========================================================
   27. DISPLAY UPDATED MATERIAL
=========================================================*/

SELECT * FROM Material WHERE Material_ID = 102;


/*=========================================================
   28. DELETE A PENDING PURCHASE ORDER
=========================================================*/

DELETE FROM Purchase_Order_Details WHERE PO_ID = 5003;
DELETE FROM Purchase_Order WHERE PO_ID = 5003;

COMMIT;


/*=========================================================
   29. DISPLAY REMAINING PURCHASE ORDERS
=========================================================*/

SELECT * FROM Purchase_Order;


/*=========================================================
   30. VERIFY PURCHASE ORDER DETAILS
=========================================================*/

SELECT * FROM Purchase_Order_Details;

/*=========================================================
   END OF INVENTORY CONTROL SYSTEM
=========================================================*/
