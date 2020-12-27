# List each country name where the population is larger than that of 'Russia'.
SELECT name 
FROM world
WHERE population >
 (SELECT population 
  FROM world
  WHERE name='Russia');

# Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.  
SELECT name
FROM world
WHERE (gdp/population) >
   (SELECT (gdp/population)
    FROM world
    WHERE name = 'United Kingdom')
AND continent = 'Europe';

# List the name and continent of countries in the continents containing
# either Argentina or Australia. Order by name of the country.
SELECT name, continent
FROM world
WHERE continent =
   (SELECT continent
    FROM world
    WHERE name ='Australia')
OR continent =
   (SELECT continent
    FROM world
    WHERE name ='Argentina')
ORDER BY name;

# Which country has a population that is more than Canada but less than Poland?
# Show the name and the population.
SELECT name, population
FROM world
WHERE population <
   (SELECT population
    FROM world
    WHERE name = 'Poland')
AND population >
   (SELECT population
    FROM world
    WHERE name = 'Canada');
    
# Show the name and the population of each country in Europe.
# Show the population as a percentage of the population of Germany.
SELECT name, CONCAT
  (ROUND((100 * (population/
   (SELECT population
    FROM world
    WHERE name = 'Germany'))), 0), '%') 
AS 'Percentage'
FROM world
WHERE continent = 'Europe';

# Which countries have a GDP greater than every country in Europe?
SELECT name
FROM world
WHERE gdp > 
    ALL(SELECT gdp
    FROM world
    WHERE continent = 'Europe'
    AND gdp != 0);
    
# Find the largest country (by area) in each continent,
# show the continent, the name and the area:
SELECT continent, name, area
FROM world x
WHERE area >= 
    ALL(SELECT area
    FROM world y
    WHERE y.continent = x.continent
    AND area > 0);
    
# List each continent and the name of the country that comes
# first alphabetically.
SELECT continent, name
FROM world x
WHERE x.name =
     ALL(SELECT name
     FROM world y
     WHERE x.continent = y.continent
     ORDER BY name
     LIMIT 1);
     
# Find the continents where all countries have a population <= 25000000.
# Then find the names of the countries associated with these continents.
# Show name, continent and population.
SELECT name, continent, population
FROM world
WHERE continent NOT IN 
    (SELECT continent
    FROM world
    WHERE population > 25000000);
    






