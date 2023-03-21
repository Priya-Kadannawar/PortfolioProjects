SELECT * FROM Data1;

SELECT * FROM Data2;

-- TOTAL POPULATION OF INDIA

SELECT Sum(Population) as Total_Population FROM Data2;


-- AVERAGE GROWTH PERCENTAGE

SELECT Avg(Growth)*100 as Avg_growth FROM Data1;


--AVERAGE GROWTH PERCENTAGE PER STATE (Highest to Lowest)

SELECT State, Round(Avg(Growth)*100,2) as Avg_growth_Percentage FROM Data1
GROUP BY State
ORDER BY Avg_growth_Percentage Desc;


-- TOP 5 STATES SHOWING HIGHEST GROWTH RATE 

SELECT TOP(5) State,Round(Avg(Growth)*100,2) as Avg_growth_Percentage FROM Data1
GROUP BY State
ORDER BY Avg_growth_Percentage DESC;



-- 3 STATES SHOWING LEAST GROWTH RATE 

SELECT TOP(3) State,Round(Avg(Growth)*100,2) as Avg_growth_Percentage  FROM Data1
GROUP BY State
ORDER BY Avg_growth_Percentage;



--STATE WISE AVERAGE LITERACY RATE

SELECT State, Round(Avg(Literacy),0) as Avg_Literacy FROM Data1
GROUP BY STATE;



--STATE WISE AVERAGE LITERACY RATE HAVING LITERACY RATE > 90 

SELECT State, Round(Avg(Literacy),0) as Avg_Literacy FROM Data1
GROUP BY STATE
HAVING Round(Avg(Literacy),0) > 90;



--TOP 5 STATES WITH HIGHEST LITERACY RATE

SELECT TOP(5) State,Round(Avg(Literacy),0) as Avg_Literacy FROM Data1
GROUP BY State
ORDER BY Avg_Literacy DESC;



--BOTTOM 5 STATES WITH LOWEST LITERACY RATE

SELECT TOP(5) State,Round(Avg(Literacy),0) as Avg_Literacy FROM Data1
GROUP BY State
ORDER BY Avg_Literacy ASC;



-- STATE WISE AVERAGE SEX_RATIO

SELECT state, Round(Avg(Sex_Ratio),0) AS Avg_sex_ratio FROM Data1
GROUP BY State;



-- STATES HAVING AVERAGE SEX RATIO > 1000
SELECT state, Round(Avg(Sex_Ratio),0) AS Avg_sex_ratio FROM Data1
GROUP BY State
HAVING Round(Avg(Sex_Ratio),0) > 1000 ;



-- SHOWING TOP 5 AND BOTTOM 5 STATES W.R.T AVERAGE LITERACY RATE
--( USING TEMPORARY TABLES)

CREATE TABLE #top5
( State nvarchar(255),
  topstates float
  )

INSERT INTO #top5
SELECT TOP(5) State,Round(Avg(Literacy),0) as Avg_Literacy FROM Data1
GROUP BY State
ORDER BY Avg_Literacy DESC;

CREATE TABLE #bottom5
( State nvarchar(255),
  Bottomstates float
  )

INSERT INTO #bottom5
SELECT TOP(5) State,Round(Avg(Literacy),0) as Avg_Literacy FROM Data1
GROUP BY State
ORDER BY Avg_Literacy ;

SELECT * from #top5
UNION 
SELECT * from #bottom5
ORDER BY Topstates DESC;



--FINDING TOTAL MEN AND TOTAL WOMEN IN EACH STATE
--(USING JOINS)

SELECT d.State, SUM(d.male_population) as Total_males, SUM(d.female_population) as Total_females FROM
(SELECT c.district,c.state, round(c.population/(c.sex_ratio+1),0) as Male_Population, round((c.population-(c.population/(c.sex_ratio+1))),0) as Female_Population From
(
SELECT Data1.District, Data1.State, Data1.Sex_Ratio/1000 as sex_ratio, Data2.Population
FROM Data1
INNER JOIN Data2
ON Data1.District = Data2.District
) as c) d
GROUP BY d.State;



-- DISPLAY TOP 3 DISTRICTS FROM EACH STATE WITH HIGHEST LITERACY RATE
Select a.* FROM 
(SELECT state, district, literacy, 
rank() OVER (PARTITION BY state ORDER BY literacy DESC) as Rank from Data1) as a
WHERE a.rank in (1,2,3)




