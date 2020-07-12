# Pewlett-Hackard HQ

## Employee Analysis

### An analysis of the current and retiring employees in the Pewlett-Hackard Company

#### The Silver Tsunami

We began our analysis with gathering data of all the employees in our company. Then we created an Entity Relationship Diagram (ERD) to simplify the questions we were given to solve. These tables contained:
- Departments
- Employees
- Department Employees
- Department Managers
- Salaries
- Titles

{!}[ERD.png]

To update our company database, we installed PostgreSQL 11 and switched to SQL database to better understand and ask questions about the data.

Following advice from the upper management, we were asked to determine the total number of employees per title who will be retiring and identify employees who are eligible to participate in a mentorship program. 

Figuring this out will help prepare for the “silver tsunami” as many current employees reach retirement age.

#### Duplicate Employees and Mentorship

By using PostgreSQL 11's ability to handle large databases and perform multiple queries, we could trust the software to do its job. First, we designed the schema to hold the data. Then we created a list of retiring employees and current employees using our knowledge of aliasing, filtering, joining, and creating new tables. 

Our first challenge was encountering duplicate employees in the employees per title data table. The table contained duplicates for employees since some of them were promoted in their career. Therefore, we used advanced a PostgreSQL method which allowed us to count unique employees and keep the most recent given title. If it were not for some clever Google-Fu, we would have been stuck in a rut, or would have used a longer solution with more queries. The last step was to generate of count of employees for each unique title.

To create a list of possible mentors, we had to engineer a double inner join query from the current employees and include a date parameter which constrained our table to employees only born in 1965 that may become eligible to serve as mentors for the "silver tsunami".

#### Data Analysis

With our code corrected and queriers simplified, we generated quite of few tables to illuminate our analysis. Here are some numbers:
- 41380 employees will be retiring 
- Finance department will have the least employees retiring: 1908
- Development department will have the most employees retiring: 9281
- 33118 employees with unique titles will be retiring
- 1549 potential mentors may be enlisted to help the silver tsunami wave 

Some limitations could have been the lack of recent data, and specific locations of branches, since it could be easier to prioritize certain locations that would need more funding and resources to mitigate new prospective employees. Thus, adding location data, and branch financing based on location will help propagate this analysis onto the next step.
