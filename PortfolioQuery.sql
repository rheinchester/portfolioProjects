-- CSFWGO

Select * 
From portfolio..[covid-data-shrinked]


Select * 
From portfolio..[owid-deaths]

-- Select data to be used

--Select Location, date, total_cases, total_deaths,  (total_deaths/total_cases)*100 as DeathPercentage where total_deaths or total_cases not = 0
--From portfolio..[owid-deaths]
--order by 1, 2

--SELECT Location, date, total_cases, total_deaths, 
--       CASE 
--           WHEN CAST(total_cases AS FLOAT) = 0 THEN 0
--           ELSE (CAST(total_deaths AS FLOAT) / CAST(total_cases AS FLOAT)) * 100
--       END AS DeathPercentage
--FROM portfolio..[owid-deaths]
--WHERE CAST(total_cases AS FLOAT) != 0 OR CAST(total_deaths AS FLOAT) != 0 
--ORDER BY 1, 2;



-- Look at total cases vs total deaths in canada
SELECT Location, date, total_cases, total_deaths,
	CASE 
		WHEN CAST(total_cases AS FLOAT) = 0 THEN 0
		ELSE (CAST(total_deaths AS FLOAT) / CAST(total_cases AS FLOAT)) * 100
	END AS DeathPercentage
FROM portfolio..[owid-deaths]
Where location like '%canada%'


-- Looking at total cases vs population

--Select Location, date, total_cases, total_deaths, population  (population/total_cases)*100 as PopulationPercentage
--From portfolio..[covid]
--order by 1, 2



--Shows population percentage of people in canada
SELECT Location, date, total_cases, pop,
	CASE 
		WHEN CAST(total_cases AS FLOAT) = 0 THEN 0
		ELSE (CAST(total_cases AS FLOAT) / CAST(pop AS FLOAT)) * 100
	END AS PopPercentage
FROM portfolio..[covid-data-shrinked]
WHERE location like '%canada%'

--Shows Showing infection rate from lowest to highest
SELECT Location, date, total_cases, pop,
	CASE 
		WHEN CAST(total_cases AS FLOAT) = 0 THEN 0
		ELSE (CAST(total_cases AS FLOAT) / CAST(pop AS FLOAT)) * 100
	END AS PopPercentage
FROM portfolio..[covid-data-shrinked]

--Shows population percentage of people in canada (Contains null data)
SELECT Location, date, total_cases, pop,
	CASE 
		WHEN CAST(total_cases AS FLOAT) = 0 THEN 0
		ELSE (CAST(total_cases AS FLOAT) / CAST(pop AS FLOAT)) * 100
	END AS PopPercentage
FROM portfolio..[covid-data-shrinked]
Order by PopPercentage


--Shows population percentage of people in canada (Removing null data)
-- Shows population percentage of people in Canada
SELECT Location, date, total_cases, pop,
    CASE 
        WHEN CAST(total_cases AS FLOAT) = 0 THEN 0
        ELSE (CAST(total_cases AS FLOAT) / CAST(pop AS FLOAT)) * 100
    END AS PopPercentage
FROM portfolio..[covid-data-shrinked]
WHERE (CAST(total_cases AS FLOAT) / CAST(pop AS FLOAT)) * 100 IS NOT NULL
ORDER BY PopPercentage;



-- Looking for countries with the highest infection rate compared to population
SELECT 
    Location, 
    pop, 
    MAX(total_cases) AS HighestInfectionCount, 
    MAX(total_cases) / CAST(pop AS FLOAT) * 100 AS InfectionRatePercentage
FROM 
    portfolio..[covid-data-shrinked]
WHERE 
    Location IN ('Australia', 'Austria', 'Belgium', 'Canada', 'Chile', 'Colombia', 'Costa Rica', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland', 'Israel', 'Italy', 'Japan', 'Korea', 'Latvia', 'Lithuania', 'Luxembourg', 'Mexico', 'Netherlands', 'New Zealand', 'Norway', 'Poland', 'Portugal', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 'Switzerland', 'Turkey', 'United Kingdom', 'United States')
GROUP BY 
    Location, pop
ORDER BY 
    InfectionRatePercentage DESC;






	
-- Looking for countries with the highest Death rate compared to population
SELECT 
    Location, 
    pop, 
    MAX(total_deaths) AS HighestDeathCount, 
    MAX(total_deaths) / CAST(pop AS FLOAT) * 100 AS InfectionDeathPercentage
FROM 
    portfolio..[covid-data-shrinked]
WHERE 
    Location IN ('Australia', 'Austria', 'Belgium', 'Canada', 'Chile', 'Colombia', 'Costa Rica', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland', 'Israel', 'Italy', 'Japan', 'Korea', 'Latvia', 'Lithuania', 'Luxembourg', 'Mexico', 'Netherlands', 'New Zealand', 'Norway', 'Poland', 'Portugal', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 'Switzerland', 'Turkey', 'United Kingdom', 'United States')
GROUP BY 
    Location, pop
ORDER BY 
    InfectionDeathPercentage DESC;

--G7 Counties: ('Canada', 'France', 'Germany', 'Italy', 'Japan', 'United Kingdom', 'United States') 
 
--('Australia', 'Austria', 'Belgium', 'Canada', 'Chile', 'Colombia', 'Costa Rica', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland', 'Israel', 'Italy', 'Japan', 'Korea', 'Latvia', 'Lithuania', 'Luxembourg', 'Mexico', 'Netherlands', 'New Zealand', 'Norway', 'Poland', 'Portugal', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 'Switzerland', 'Turkey', 'United Kingdom', 'United States')




-- Looking for countries with the highest Death rate compared to population
SELECT 
    Location, 
    pop, 
    MAX(total_deaths) AS HighestDeathCount, 
    MAX(total_deaths) / CAST(pop AS float) * 100 AS InfectionDeathPercentage
FROM 
    portfolio..[covid-data-shrinked]
WHERE 
    Continent IS NOT NULL AND Location IN ('Australia', 'Austria', 'Belgium', 'Canada', 'Chile', 'Colombia', 'Costa Rica', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland', 'Israel', 'Italy', 'Japan', 'Korea', 'Latvia', 'Lithuania', 'Luxembourg', 'Mexico', 'Netherlands', 'New Zealand', 'Norway', 'Poland', 'Portugal', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 'Switzerland', 'Turkey', 'United Kingdom', 'United States')
GROUP BY 
    Location, pop
ORDER BY 
     InfectionDeathPercentage DESC;







-- Looking for countries with the highest Death rate compared to population
SELECT 
    Location, 
    pop, 
    MAX(total_cases) AS HighestInfectionCount, 
    MAX(total_cases) / CAST(pop AS FLOAT) * 100 AS InfectionRatePercentage,
	MAX(total_deaths) AS HighestDeathCount, 
    MAX(total_deaths) / CAST(pop AS float) * 100 AS InfectionDeathPercentage,
	total_deaths/total_cases AS DeathsPerCases
FROM 
    portfolio..[covid-data-shrinked]
WHERE 
    Continent IS NOT NULL AND Location IN ('Australia', 'Austria', 'Belgium', 'Canada', 'Chile', 'Colombia', 'Costa Rica', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland', 'Israel', 'Italy', 'Japan', 'Korea', 'Latvia', 'Lithuania', 'Luxembourg', 'Mexico', 'Netherlands', 'New Zealand', 'Norway', 'Poland', 'Portugal', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 'Switzerland', 'Turkey', 'United Kingdom', 'United States')
GROUP BY 
    Location, pop
ORDER BY 
     InfectionRatePercentage DESC;


SELECT
    Location, 
    pop, 
    MAX(total_cases) AS HighestInfectionCount, 
    MAX(total_cases) / CAST(pop AS FLOAT) * 100 AS InfectionRatePercentage,
    MAX(total_deaths) AS HighestDeathCount, 
    MAX(total_deaths) / CAST(pop AS FLOAT) * 100 AS InfectionDeathPercentage,
    SUM(CAST(total_deaths AS FLOAT)) / SUM(CAST(total_cases AS FLOAT)) AS DeathsPerCases
FROM 
    portfolio..[covid-data-shrinked]
WHERE 
    Continent IS NOT NULL 
    AND Location IN ('Australia', 'Austria', 'Belgium', 'Canada', 'Chile', 'Colombia', 'Costa Rica', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland', 'Israel', 'Italy', 'Japan', 'Korea', 'Latvia', 'Lithuania', 'Luxembourg', 'Mexico', 'Netherlands', 'New Zealand', 'Norway', 'Poland', 'Portugal', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 'Switzerland', 'Turkey', 'United Kingdom', 'United States')
GROUP BY 
    Location, pop
ORDER BY 
    DeathsPerCases DESC;

-- LET'S BREAK THINGS DOWN BY CONTINENT

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From portfolio..[covid-data-shrinked]
-- Where location like '%states%'
Where continent is not null
Group by continent
order by TotalDeathCount desc




--Select date, SUM(new_cases), SUM(cast(new_deaths AS INT)), SUM(New_deaths AS INT)/SUM(New_Cases)*100 as
--	DeathPercentage
--From portfolio..[covid-data-shrinked]
---- Where location like '%states%'
--where continent is not null
--Group By date
--order by 1,2

-- Deaths per cases
SELECT 
    date, 
    SUM((CAST(new_cases AS INT))) AS TotalNewCases, 
    SUM(CAST(new_deaths AS INT)) AS TotalNewDeaths, 
    SUM(CAST(total_deaths AS FLOAT)) / SUM(CAST(total_cases AS FLOAT)) AS DeathsPerCases
FROM 
    portfolio..[covid-data-shrinked]
WHERE 
    continent IS NOT NULL
GROUP BY 
    date
ORDER BY 
    date, TotalNewCases;


---- Joining vaccination and death tables

-- Looking at population density vs vaccinations
-- https://chatgpt.com/share/668c903a-0ea5-48d6-91f2-88d1188d5477
SELECT 
	dea.continent, 
	dea.location,
	dea.date, 
	dea.population_density, 
	vac.new_vaccinations,
	SUM(CONVERT(BIGINT, vac.new_vaccinations)) 
	OVER (PARTITION by dea.location ORDER by dea.location, dea.date)
	AS RollingPeopleVaccinated

FROM portfolio .. [owid-deaths] dea
JOIN portfolio .. [owid-deaths_vaccinations] vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is not null
ORDER BY dea.continent, dea.location, dea.date;


-- Creating view to store data for later visualizations
CREATE view CasesPerPopulation as
-- Looking for countries with the highest infection rate compared to population

CREATE VIEW CasesPerPopulation AS
-- Looking for countries with the highest infection rate compared to population
SELECT 
    Location, 
    pop, 
    MAX(total_cases) AS HighestInfectionCount, 
    (MAX(total_cases) / CAST(pop AS FLOAT)) * 100 AS InfectionRatePercentage
FROM 
    portfolio..[covid-data-shrinked]
WHERE 
    Location IN ('Australia', 'Austria', 'Belgium', 'Canada', 'Chile', 'Colombia', 'Costa Rica', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland', 'Israel', 'Italy', 'Japan', 'Korea', 'Latvia', 'Lithuania', 'Luxembourg', 'Mexico', 'Netherlands', 'New Zealand', 'Norway', 'Poland', 'Portugal', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 'Switzerland', 'Turkey', 'United Kingdom', 'United States')
GROUP BY 
    Location, pop;



-- Wrong view creation
----SELECT 
--    Location, 
--    pop, 
--    MAX(total_cases) AS HighestInfectionCount, 
--    MAX(total_cases) / CAST(pop AS FLOAT) * 100 AS InfectionRatePercentage
--FROM 
--    portfolio..[covid-data-shrinked]
--WHERE 
--    Location IN ('Australia', 'Austria', 'Belgium', 'Canada', 'Chile', 'Colombia', 'Costa Rica', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland', 'Israel', 'Italy', 'Japan', 'Korea', 'Latvia', 'Lithuania', 'Luxembourg', 'Mexico', 'Netherlands', 'New Zealand', 'Norway', 'Poland', 'Portugal', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 'Switzerland', 'Turkey', 'United Kingdom', 'United States')
