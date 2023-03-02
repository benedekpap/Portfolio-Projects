-- Covid_Deaths database

-- Basic data check
SELECT location, date, total_cases, new_cases, total_deaths, population
From project_portfolio.covid_deaths
ORDER BY 1,2;

-- Shows likelihood of dying if you contract with covid in Hungary
SELECT location, date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 AS 'Death_percentage'
From project_portfolio.covid_deaths
Where location like 'Hungary'
ORDER BY 1,2 ;

-- Looking at Total Cases vs Population
-- Shows what percentage of population got infected with Covid
SELECT location, date, total_deaths, total_cases, population, (total_cases/population)*100 AS 'Infected_percentage'
From project_portfolio.covid_deaths
Where location like 'Hungary'
Order BY 1,2;

-- Looking at Countries with the highest infection rate compared to population
SELECT location, max(total_cases) as Highest_Infection_Count, population, max((total_cases/population))*100 AS 'Max_Infected_percentage'
From project_portfolio.covid_deaths
GROUP BY Location, Population
ORDER BY 4 DESC, 1,2;

-- Looking at Countries with the highest average death rate
SELECT location, AVG((total_deaths/total_cases)*100) AS 'Average_Death_percentage'
From project_portfolio.covid_deaths
GROUP BY location
ORDER BY 2 DESC;

-- Looking at Countries with the highest death count per population
SELECT location, population, max(total_deaths) AS 'Total_deaths_max', max(total_deaths)/max(Population)*100 as 'Total_deaths_per_pop_Perc'
From project_portfolio.covid_deaths
Where continent is NULL AND location not like '%income%'
-- Where continent is not NULL
GROUP BY location, population
ORDER BY 4 DESC;

-- Checking non country data types
SELECT continent, location
From project_portfolio.covid_deaths
Where continent is NULL
GROUP BY location, continent
ORDER BY 1,2;

-- Showing the continents with the highest death count
SELECT location, population, max(total_deaths) AS 'Total_deaths_max', max(total_deaths)/max(Population)*100 as 'Total_deaths_per_pop_Perc'
From project_portfolio.covid_deaths
Where continent is NULL AND location not like '%income%'
GROUP BY location, population
ORDER BY 3 DESC;

-- Showing the continents with the highest death percentage
SELECT location, max(total_deaths)/max(total_cases)*100 as 'Total_death_percentage'
FROM project_portfolio.covid_deaths
Where continent is NULL AND location not like '%income%'
GROUP BY location
ORDER BY 2 DESC; 


-- Covid_vaccinations database


-- Showing the number of total tests, and fully vaccinated people in each country, in order of their above 65 years old population
SELECT cov.location, sum(cov.new_tests) as 'Total_tests', max(cov.people_fully_vaccinated) as 'People_fully_vaccinated', 
max(cov.aged_65_older) as 'Above_65_population' 
FROM project_portfolio.covid_vaccinations as cov
WHERE cov.continent is not NULL
GROUP BY cov.location
ORDER BY 4 DESC;
