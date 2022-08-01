# Smart_Performance_Database_System

In this project, we are using a relational database which contains multiple tables of data with rows and columns that are in a relation through special key fields. This database is more flexible and provides functionality, for instance, read, create, update and delete. Normally, this database adopts Structured Query Language (SQL), a standard and easy programming interface for database interaction. 
In this case, there are three types of relationships exist in this relational database which are 
1.	one to one
- In one to one relationship, it determines that one table record relates to another record in another table (Between "Location" and "Employee_Info" table).

2.	one to many
- For one to many relationship, it means that one table record relates to multiple records in another table (Between "Employee_Info" and "Video" and "HRMS" table)

3.	many to one 
- For many to one relationships, it states that more than one table record relates to another table record (Between "Video" and "HRMS" table and "Monthly Performance" view)

## Why SQL?
- It is the industry titan and most popular system worldwide for dealing with the relational and structured database.
- The data samples used in this project is related in nature. The standard way of working with such databases is using SQL – the structured Query Language. It's also best for fast analytical queries.
- SQL databases are long established with fixed schema design and a set structure. This difference in schema makes relational SQL databases a better option for applications that require multi-row transactions such as an accounting system or for legacy systems that were built for a relational structure. 
- SQL is a mature technology and many experienced developers understand it. Because of this, great support is available for all SQL databases from their vendors. There are even a lot of independent consultants who can help with the SQL database for very large scale deployments.

## Project Goals & Objectives
### Goals
- Create an efficient solution to keep and analyse the employee performance data
- Maximize the information that can be gathered from the employee performance data

### Objectives
- Reduce the time spent on Employee Performance Evaluation process
- Bring a more effective and flexible system to help HR extract data in various ways to evaluate Employee Performance
- Be able to analyse get more insights from the HRMS and Employee data to identify and make improvements when needed

## Database Schema
![image](https://user-images.githubusercontent.com/34255556/182132161-e861127f-80dc-4575-8605-cb54e27f9e50.png)

We have applied a relational database model in order to connect different entities with each other using MySQL: Employee_Info, Location, Video and HRMS. 

In a nutshell, management will be able to extract employees’ information, attendance status and monthly performances by location, department and more, easily as the
video table and HRMS table are linked to Employee_Info table through Emp_ID column and location table is linked to Employee_Info table through Loc_ID column. 

## Database Dictionary
### Location Table
This table was created to keep on track the work location of each employee since the organization is a Multinational Company which was assumed to have a physical location in Malaysia, Thailand, Singapore, Indonesia, Vietnam, Philippines and Cambodia. The primary key of this table is Loc_ID which denotes each unique location as stated below:
- “101” is Malaysia
- “102” is Thailand
- “103” is Singapore 
- “104” is Indonesia
- “105” is Vietnam
- “106” is Philippines
- “107” is Cambodia

Column Name	| Description	| Data Type	| Constraints
--- | --- | --- | --- 
Loc_ID | PRIMARY KEY: Represents designated id of employees work location between 101 and 107 | VARCHAR(10) | UNIQUE
StreetName | Represents the office level and number, building name and street name which respective to employees work location | VARCHAR(200)	
State	| Represents the states of the employees work location | VARCHAR(20)	
City | Represents the city of the employees work location | VARCHAR(20)	
Post_Code | Represents the postcode of the employees work location | VARCHAR(10) | NOT NULL
Country | Represents the country of the employees work location | VARCHAR(20) | NOT NULL

From this table, we use Loc_ID as a primary key in order to link the Location table with the Employee_Info table. Thus, when we want to know each employee's work location, this can be easily done by searching with their Loc_ID.

### Employee Information (Employee_Info) Table

This table is designed to keep all the basic information of employees, their employment status, designation, date of joining, date of resignation, department and managers that they report to. Emp_ID is the unique id that has been created for every employee in the organization.

Column Name	| Description	| Data Type	| Constraints
--- | --- | --- | --- 
Emp_ID | PRIMARY KEY: Represents unique designated ID of employee. | VARCHAR(10) | UNIQUE
First_Name | Represents the first name of the employee. | VARCHAR(20) | NOT NULL
Last_Name | Represents last name of the employee | VARCHAR(20) | NOT NULL
Gender | Represents gender of the employee as “male”, ”female” or “transgender” | VARCHAR(1) | Check (Gender in ("m", "f", "t"))
DOB	| Represents date of birth of the employee	| DATE	| NOT NULL
Emp_status | Represents the employee’s employment status as described in constraints. | VARCHAR(15) | NOT NULL <br> Check (Emp_status in ("permanent", "contractual", "probation", "resigned"))
Designation |	Represents the employee’s designation as described in constraints | VARCHAR(20) | NOT NULL <br> Check (Designation in ("executive", "manager","asst.manager"))
Department | Represents department of the employee as described in constraints.	| VARCHAR(20) |	NOT NULL <br> Check (Department in ("Finance","IT","Admin","HR","Marketing"))
Salary	| Represents the basic monthly salary of the employee	| DECIMAL (10,2)	| NOT NULL
Image |	Represents the file name of the employee’s passport size picture	| VARCHAR(50)	
Date_of_joining	| Represents the first date that the employee joined the company	| DATE	| NOT NULL
Date_of_resignation |	Represents the last date that the employee services to the company	| DATE	| Check (Date_of_resignation > Date_of_joining)
Manager_ID |	Represents the Emp_ID of the manager that the employee reports to	| VARCHAR(10)	
Loc_ID	| FOREIGN KEY: Represents designated IDs of employee’s work locations between 101 and 107	| VARCHAR(10)	| NOT NULL

From this table, Emp_ID is assigned as a primary key which links all the rows to other tables, namely, Video table and HRMS table. Thus, we can review details of an employee from the Video table and HRMS table using the Emp_ID. We adopt Loc_ID as a foreign key from the Location table in order to match the employees’ work location. 

### Video Table

This table is to store the data captured from the daily video recordings of the employees. We are capturing their Attendance, Log in time, Log out time, Break time in minutes and Total working hours in a day. Vid_ID is the unique ID that represents the data from each video. 

Column Name	| Description	| Data Type	| Constraints
--- | --- | --- | --- 
Vid_ID	| PRIMARY KEY: Represents the designated ID indexing of each video record	| VARCHAR(10)	| UNIQUE
Video_URL	| Represents the video path for each video	| VARCHAR(200)	| UNIQUE
Date_recorded	| Represents the date that the video is recorded	| DATE	
Attendance	| Represents the employees’ attendance status	| VARCHAR(10)	| NOT NULL <br> Check (Attendance in ("present", "AL", "EL", "SL", "NPL", ”PH”))
LogInTime | Represents the Log in time for each employee based on the video	| TIME | Check (LogInTime > '06:00:00' AND LogOutTime < '23:59:59' AND LogInTime < LogOutTime)
LogOutTime | Represents the Log out time of each employee based on the video | TIME	
BreakMinutes	| Represents the break time in minutes of each employee based on the video	| INTEGER (INT)	
WorkHours |	Represents the productive hours of employee based on the video	| DECIMAL (4,2)	
Emp_ID	| FOREIGN KEY: Unique ID that represents the employee	| VARCHAR(10)	| NOT NULL

Vid_ID is the PRIMARY KEY for this table that consists of data from daily video recording. We use Emp_ID as FOREIGN KEY from the Employee_Info table to relate data from both Video table and Employee_Info table. Thus, we can review each employee's attendance status as well as their productive and non-productive hours using the Emp_ID.

### HRMS Table

This table is  to store the data extracted from the HRMS system and will be useful to justify the employee’s performance on a monthly basis. The HRMS data also includes Manager’s remarks on each employee’s performance. HRMS_ID is the unique ID that represents the HRMS data attached to each employee on a monthly basis.

Column Name	| Description	| Data Type	| Constraints
--- | --- | --- | --- 
HRMS_ID	| PRIMARY KEY: Represents the unique ID of HRMS data for each employee	| VARCHAR(10)	| UNIQUE
Emp_ID	| FOREIGN KEY: Unique ID that represents the employee	| VARCHAR(10)	| NOT NULL
P_Year	| Represents the year that the HRMS data was extracted	| YEAR	
P_Month	| Represents the month that the HRMS data was extracted	| INTEGER(INT)	| Check (p_Month BETWEEN 1 AND 12)
NumberofMilestoneAchieved_Efficiecy |	Represents the number of milestones completed by the employee in the month	| INTEGER(INT)	
CustomerFeedbackScore_Efficiency	| Represents a score based on customer feedback earned by the employee in the month	| INTEGER(INT)	| DEFAULT 1 <br> Check (CustomerFeedbackScore_Efficiency between 1 and 10) 
ErrorsFound_Quality	| Shows if an employee has made an error in the month	| INTEGER(INT)	| DEFAULT 0 <br> Check (ErrorsFound_Quality between 0 and 1)
NumberofReworks_Quality	| Represents the number of reworks done to rectify the identified errors | INTEGER(INT)	| DEFAULT 0
Behavioral_Score	| Represents a score earned by the employee based on his behaviour in the month	| INTEGER(INT)	| DEFAULT 1 <br> Check (Behavioural_Score between 1 and 10)
Manager_remark	| Represents the comments given by manager on the employees performance for the month	| VARCHAR(200)	

From the table, HRMS_ID is set as a primary key for HRMS data of each employee in a month. We use Emp_ID as foreign key from the Employee_Info table to relate both the HRMS table and the Employee_Info table. Thus, we can review and evaluate performance of each employee in a month by joining the 2 tables using the Emp_ID.

### Monthly Performance (View)

A view is created to extract data from all 4 tables that we have in the database and get useful information about employees’ monthly performance.

Column Name	| Description	| Table Source	| Scoring Formula
--- | --- | --- | --- 
HRMS_ID	| PRIMARY KEY: Unique ID representing HRMS data for each employee	| HRMS
Emp_ID	| FOREIGN KEY: Unique ID that represents the employee	| HRMS
P_Year	| Represents the year that the HRMS data was extracted	| HRMS
P_Month	| Represents the month that the HRMS data was extracted	| HRMS
NumberofMilestoneAchieved_Efficiency	| Represents the number of milestones completed by the employee in the month	| HRMS	| 0 < NumberOfMilestonesAchieved <= 5:  1 point <br> 5 < NumberOfMilestonesAchieved <= 7:  2 points <br> 7 < NumberOfMilestonesAchieved <= 10:  3 points <br> 10 < NumberOfMilestonesAchieved: 4 points
CustomerFeedbackScore_Efficiency |	Represents a score based on customer feedback earned by the employee in the month |	HRMS | Use the original score extracted from HRMS table
Efficiency_Score |	Scored based on milestone achieved and customer feedback | | ((Score from NumberOfMilestonesAchieved x 2.5) + CustomerFeedbackScore) / 2
TotalWorkHours_timeliness |	Represents total work hours that an employee has committed in the month | |	SELECT MONTH(date_recorded) AS p_Month, Emp_ID, SUM(video.WorkHours) AS TotalWorkHours_timeliness FROM video Group By MONTH(date_recorded), Emp_ID
UnplannedLeavesCount_timeliness |	Represents total unplanned leaves (EL, SL, NPL) that an employee has committed in the month | | ((SELECT p_Month, Emp_ID, SUM(counting) AS UnplannedLeavesCount_timeliness FROM (SELECT MONTH(date_recorded) AS p_Month, Emp_ID, (CASE WHEN Attendance NOT IN ('present','PH','AL') THEN 1 ELSE 0 END) AS counting FROM video) temp GROUP BY p_Month, Emp_ID)
Timeliness_Score |	Scored based on total work hours and number of unplanned leaves	| | TotalWorkHours > 170 & UnplannedLeaves is null: 10 points <br> TotalWorkHours > 170 & UnplannedLeaves is not null: 9 points <br> TotalWorkHours > 160 & UnplannedLeaves is null: 8 points <br> TotalWorkHours > 160 & UnplannedLeaves is not null: 7 points <br> TotalWorkHours > 150 & UnplannedLeaves is null: 6 points <br> TotalWorkHours > 150 & UnplannedLeaves is not null: 5 points <br> TotalWorkHours > 140 & UnplannedLeaves is null: 4 points <br> TotalWorkHours > 140 & UnplannedLeaves is not null: 3 points <br> TotalWorkHours > 130 & UnplannedLeaves is null: 2 points ELSE 1 point
ErrorsFound_Quality |	Represents the number of errors identified in the employee have completed task in the month	| HRMS
NumberofReworks_Quality	| Represents the number of reworks done to rectify the identified errors | HRMS
Quality_Score |	Scored based on errors and number of reworks | | No ErrorsFound: 10 points for Quality <br> If Error found, based on NumberOfReworks : <br> NumberOfReworks <3: 9 points <br> NumberOfReworks <5: 8 points <br> NumberOfReworks <7: 7 points <br> NumberOfReworks <9: 6 points <br> NumberOfReworks <11: 5 points <br> NumberOfReworks <13: 4 points <br> NumberOfReworks <15: 3 points <br> NumberOfReworks <17: 2 points <br> NumberOfReworks >17: 1 point
Behavioral_Score	| Represents a score earned by the employee based on his behaviour in the month	| HRMS	| Use the original score extracted from HRMS
Manager_remark	| Represents the comments given by manager on the employees performance for the month |	HRMS	| Use the original data extracted from HRMS

The view can be merged with the Employee_info table on the Emp_ID for further analysis and insights gathering based on the background details of the employee.

Refer to the coding file named: SQL Coding.sql for more details about how the above tables and view are designed and linked together.

## Legality
This is an internship project made with 360DIGITMG for non-commercial uses ONLY. This project will not be used to generate any promotional or monetary value for me, the creator, or the user.
