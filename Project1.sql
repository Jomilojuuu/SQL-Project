#Data Exploration of Covid Data using SQL

SELECT * FROM Covid.`covidvaccines.xlsx - covidvaccines` order by 3,4;
SELECT * FROM Covid.`covideaths.xlsx - coviddeaths` order by 3,4;

# to select the data we are going to be working with for the Covid Death Data
SELECT location, date,population, total_cases, new_cases,total_deaths FROM Covid.`covideaths.xlsx - coviddeaths`;

# To show the likelihood of contracting Covid in Nigeria
Select location,date,total_cases,total_deaths, (total_cases/ total_deaths) * 100 as Death_Percentage from Covid.`covideaths.xlsx - coviddeaths`
Where location like '%Nigeria%' order by 1, 2;

#To show the tpercentage of the population in Nigeria that got covid
Select location,date,population,total_cases, (total_cases/ population) * 100 as Covid_Rate from Covid.`covideaths.xlsx - coviddeaths`
Where location like '%Nigeria%' order by 1, 2;

# Countries with the highest infection rate compared to the population
Select location,population,MAX(total_cases) as Highest_Infection_Count, MAX((total_cases/ population)) * 100 as Perecentage_Infected from Covid.`covideaths.xlsx - coviddeaths`
Group by location,population
order by Perecentage_Infected desc;

# Countries with the highest death rate per population
Select location,MAX(cast(total_deaths as signed)) as Total_Death_Count from Covid.`covideaths.xlsx - coviddeaths`
Group by location
order by Total_Death_Count desc;

# By Continent
Select location,MAX(cast(total_deaths as nchar)) as Total_Death_Count from Covid.`covideaths.xlsx - coviddeaths`
where continent is not null
group by location
order by Total_Death_Count desc;

# Global Numbers
Select location,date, total_cases, total_deaths (total_deaths /total_cases)* 100 as Death_Percentag from Covid.`covideaths.xlsx - coviddeaths`
order by 1, 2;

Select date, SUM(new_cases) as Highest_Infection_Count, MAX((total_cases/ population)) * 100 as Perecentage_Infected from Covid.`covideaths.xlsx - coviddeaths`
Group by date
order by 1,2;

# To join both tables of covid deaths and covid vaccinations
SELECT * FROM Covid.`covidvaccines.xlsx - covidvaccines` vac
JOIN Covid.`covideaths.xlsx - coviddeaths` dea
 ON vac.location = dea.location AND vac.date = dea.date;
 
 # Looking at total population vs total vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as signed))over (Partition by dea.location order by dea.location, dea.date)
FROM Covid.`covidvaccines.xlsx - covidvaccines` vac
JOIN Covid.`covideaths.xlsx - coviddeaths` dea
 ON vac.location = dea.location AND vac.date = dea.date
 where dea.continent is not null
 order by 1,2,3;
 
 
 