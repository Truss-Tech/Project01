/*******************************************
********************************************
Conestoga College Doon Campus (Program 1372)
PROG8650 - Section 2
Group Project 3 (Group 5)
Kanishka Kaushalya Makewita Appuhamilage (8803608)
Jayraj Anil Sali (8774136)
Sharmini Sathis Kumar Pillai (8808970)
Anju Arun (8811685)
Jimmy Jose (8811979)
Mohammed Yaqoob Atif (8720021)
Naveen Yaragarla (8796043)
July 31st, 2022 
********************************************
*******************************************/
USE GroupProject03_Group5;
GO

-- Sectio B - Q1 - Start
CREATE FUNCTION LastNameFirstGroup5
(
     @FirstName CHAR(25),
     @LastName CHAR(25)
)
Returns Varchar(60)
AS
BEGIN
 DECLARE @FullName VARCHAR(60);
 SELECT @FullName= RTRIM(@LastName) + ', ' + RTRIM(@FirstName);
 return @FullName
END
GO

SELECT *, [dbo].[LastNameFirstGroup5](FName, LName) AS ConcatedName
From [dbo].[EMPLOYEE];
-- Sectio B - Q1 - End

-- Sectio B - Q2 - Start
GO
CREATE VIEW EmployeesMedicalConcerns AS 
SELECT [dbo].[LastNameFirstGroup5](FName, Lname) AS EmpName, AllergyName
FROM EMPLOYEE e
INNER JOIN EMPLOYEEALLERGY x
ON e.EmployeeID = x. EMployeeID
INNER JOIN ALLERGY a
 ON a.AllergyID = x.AllergyID;

-- Select * from EmployeesMedicalConcerns;
-- Sectio B - Q2 - End

-- Section B - Q4 - Start
GO
CREATE PROCEDURE convertSalary
AS 
BEGIN
-- convert salary data type INT to char in the table first
ALTER TABLE EMPLOYEE
ALTER COLUMN Salary varchar(255)

Declare @Salary AS VARCHAR(255)
Declare @EmpID AS INT
Declare @RowCount AS INT
Declare @Counter AS INT
Declare @ConvertedVal AS NUMERIC
Declare @FinalVal AS varchar(255)

SET @RowCount = (Select COUNT(*) from [dbo].EMPLOYEE)

SET @Counter =@RowCount
WHILE ( @Counter > 0)
BEGIN
     PRINT 'The counter value is = ' +  CONVERT(VARCHAR,@Counter)
	 
     SELECT @Salary=Salary, @EmpID=EmployeeID
     FROM EMPLOYEE 
     ORDER BY EmployeeID DESC OFFSET @Counter - 1 ROWS FETCH NEXT 1 ROWS ONLY;
  
		
			  SET @ConvertedVal =  CONVERT(NUMERIC,@Salary)
			  SET @FinalVal = CONVERT(VARCHAR,FORMAT(@ConvertedVal,'0,000'))+'.00'		   
			   PRINT @FinalVal		 
			  UPDATE [dbo].[EMPLOYEE]
              SET Salary = '$'+ @FinalVal
			  Where  EmployeeID=@EmpID
     SET @Counter -=1

END

END
--EXEC convertSalary
-- SELECT * FROM EMPLOYEE
-- Section B - Q4 - End







