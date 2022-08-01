DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

## Initial coding done by Javeria for creating tables
CREATE TABLE Location
(
Loc_ID VARCHAR(10) UNIQUE,
Street_Name VARCHAR(200),
State VARCHAR(20),
City VARCHAR(20),
Post_code VARCHAR (10) NOT NULL,
Country VARCHAR(20) NOT NULL,
PRIMARY KEY (Loc_ID)
);

CREATE TABLE Employee_Info
(
Emp_ID VARCHAR(10) UNIQUE,
First_name VARCHAR(20) NOT NULL,
Last_name VARCHAR(20) NOT NULL,
Gender VARCHAR(1) CHECK (gender in ("m","f","t")),
DOB DATE NOT NULL,
Emp_status VARCHAR(15) NOT NULL CHECK (Emp_status in ("permanent", "contractual","probation","resigned")),
Designation VARCHAR(20) NOT NULL CHECK (Designation in ("executive","manager","asst. manager")),
Department VARCHAR (20) NOT NULL CHECK (Department in ("Finance","IT","Admin","HR","Marketing")),
Salary decimal(10,2) NOT NULL,
Image VARCHAR(50),
Date_of_joining DATE NOT NULL,
Date_of_resignation DATE,
Manager_ID VARCHAR(10) ,
Loc_ID VARCHAR(10) NOT NULL,
CHECK (Date_of_joining - DOB >=21),
CHECK (Date_of_resignation > Date_of_joining),
PRIMARY KEY (Emp_ID),
FOREIGN KEY (Loc_ID) references Location(Loc_ID)
);

CREATE TABLE Video
(
Vid_ID VARCHAR(10) UNIQUE,
Video_URL VARCHAR(200) UNIQUE,
Date_recorded DATE,
Attendance VARCHAR(10) NOT NULL CHECK (Attendance in ("present","AL","EL","SL","NPL","PH")),
LogInTime TIME,
LogOutTime TIME ,
BreakMinutes INT,
WorkHours decimal(4,2),
Emp_ID VARCHAR(10) NOT NULL,
CHECK (LogInTime > '06:00:00' AND LogOutTime < '23:59:59' AND LogInTime < LogOutTime),
PRIMARY KEY (Vid_ID),
FOREIGN KEY (Emp_ID) references Employee_info(Emp_ID)
);

CREATE TABLE HRMS
(
HRMS_ID	VARCHAR(10) UNIQUE,
Emp_ID	VARCHAR(10) NOT NULL,
p_Year	YEAR,
p_Month	INT CHECK (p_Month between 1 AND 12),
NumberOfMilestonesAchieved_Efficiency INT,	
CustomerFeedbackScore_Efficiency INT DEFAULT 1 CHECK (CustomerFeedbackScore_Efficiency between 1 and 10),
ErrorsFound_Quality	INT DEFAULT 0 CHECK (ErrorsFound_Quality between 0 and 1),
NumberOfReworks_Quality	INT DEFAULT 0,
Behavioural_Score INT default 1 CHECK (Behavioural_Score between 1 and 10),
Manager_Remark VARCHAR(200),
PRIMARY KEY (HRMS_ID),
FOREIGN KEY (Emp_ID) references Employee_info(Emp_ID)
);

## Initial coding done by Yixian for inserting data into MYSQL using both manual entry and data import wizard.
INSERT INTO Location
VALUES (101, 'Block 3750, Persiaran APEC, Cyber 8', 'Selangor',	'Cyberjaya', 63000,	'Malaysia'),
(102, '59, 1 Soi Sukhumvit 16, Khwaeng Khlong Toei', 'Bangkok', 'Khlong Toei', 10110, 'Thailand'),
(103, '40 Changi N Cres', '','', 499639, 'Singapore'),
(104, 'Wisma Nugra Santana Lt. 9 Suite 909 Jalan Jendral Sudirman No.Kav. 7 - 8, RT.10/RW.11, Karet Tengsin, Kecamatan Tanah Abang' , 'Jakarta'	, 'Kota Jakarta Pusat',	10250, 'Indonesia'),
(105, 'Nguyễn Sơn Hà, KHU CÔNG NGHIỆP', 'Hải Phòng', 'Lê Chân', 4000, 'Vietnam'),
(106, 'Upper McKinley Rd', 'Manila', 'Taguig', 1630, 'Philippines'),
(107, '15A Sivantha', 'Siem Reap', 'Krong', 17251, 'Cambodia');

UPDATE Location
SET State = NULL WHERE State = '';

UPDATE Location
SET City = NULL WHERE City = '';

/*** Employee_info, Video and Monthly_Performance table will be imported from csv format into MYSQL using "Table Data Import Wizard" 
to reduce redundant work on manual data entry in MYSQL.
Instructions as follows:
1. Right click on the relevant database name
2. Select "Table Data Import Wizard"
3. Select the file path for relevant csv/json file
4. Select "Use Existing tables" option for importing data into the relevant table
5. Double check the source and destination column name are mapped accordingly before finalizing the process.
6. Check the logs under "Show Logs" after importing data to identify any errors obtained and rectify it accordingly.
***/

# Temporary table (view) "monthly_performance" is created here.
CREATE VIEW monthly_performance AS
(SELECT HRMS_ID AS Perf_ID, tb1.Emp_ID, p_Year, tb1.p_Month, NumberOfMilestonesAchieved_Efficiency, CustomerFeedbackScore_Efficiency,
round(((CASE 
WHEN NumberOfMilestonesAchieved_Efficiency<=5 THEN 1
WHEN  NumberOfMilestonesAchieved_Efficiency<=7 THEN 2
WHEN  NumberOfMilestonesAchieved_Efficiency<=10 THEN 3
ELSE 4 
END) * 2.5 + CustomerFeedbackScore_Efficiency)/2, 0) AS Efficiency_Score, TotalWorkHours_timeliness,
(CASE 
WHEN UnplannedLeavesCount_timeliness IS NULL THEN 0
ELSE UnplannedLeavesCount_timeliness 
END) AS UnplannedLeavesCount_timeliness,
(CASE 
WHEN TotalWorkHours_timeliness > 170 AND UnplannedLeavesCount_timeliness IS NULL THEN 10
WHEN TotalWorkHours_timeliness > 170 AND UnplannedLeavesCount_timeliness IS NOT NULL THEN 9
WHEN TotalWorkHours_timeliness > 160 AND UnplannedLeavesCount_timeliness IS NULL THEN 8
WHEN TotalWorkHours_timeliness > 160 AND UnplannedLeavesCount_timeliness IS NOT NULL THEN 7
WHEN TotalWorkHours_timeliness > 150 AND UnplannedLeavesCount_timeliness IS NULL THEN 6
WHEN TotalWorkHours_timeliness > 150 AND UnplannedLeavesCount_timeliness IS NOT NULL THEN 5
WHEN TotalWorkHours_timeliness > 140 AND UnplannedLeavesCount_timeliness IS NULL THEN 4
WHEN TotalWorkHours_timeliness > 140 AND UnplannedLeavesCount_timeliness IS NOT NULL THEN 3
WHEN TotalWorkHours_timeliness > 130 AND UnplannedLeavesCount_timeliness IS NULL THEN 2
ELSE 1 
END) AS Timeliness_Score, ErrorsFound_Quality, NumberOfReworks_Quality,
(CASE 
WHEN ErrorsFound_Quality = 0 THEN 10
WHEN NumberOfReworks_Quality <3 THEN 9
WHEN NumberOfReworks_Quality <5 THEN 8
WHEN NumberOfReworks_Quality <7 THEN 7
WHEN NumberOfReworks_Quality <9 THEN 6
WHEN NumberOfReworks_Quality <11 THEN 5
WHEN NumberOfReworks_Quality <13 THEN 4
WHEN NumberOfReworks_Quality <15 THEN 3
WHEN NumberOfReworks_Quality <17 THEN 2
ELSE 1
END) AS Quality_Score, Behavioural_Score, Manager_Remark
FROM HRMS tb1
INNER JOIN
(SELECT MONTH(date_recorded) AS p_Month, Emp_ID, SUM(video.WorkHours) AS TotalWorkHours_timeliness FROM video
Group By MONTH(date_recorded), Emp_ID) tb2
ON tb1.Emp_ID = tb2.Emp_ID AND tb1.p_Month = tb2.p_Month
INNER JOIN
(SELECT p_Month, Emp_ID, SUM(counting) AS UnplannedLeavesCount_timeliness
FROM
(SELECT MONTH(date_recorded) AS p_Month, Emp_ID,
(CASE WHEN Attendance NOT IN ('present','PH','AL') THEN 1
ELSE 0
END) AS counting FROM video) temp
GROUP BY p_Month, Emp_ID) tb3
ON tb1.Emp_ID = tb3.Emp_ID AND tb1.p_Month = tb3.p_Month);

SELECT * FROM monthly_performance;