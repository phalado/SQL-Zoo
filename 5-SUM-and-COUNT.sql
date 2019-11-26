-- Show the total population of the world.
SELECT SUM(population)
  FROM world;

-- List all the continents - just once each.
SELECT continent
  FROM world
  GROUP BY continent;

-- Give the total GDP of Africa
SELECT SUM(gdp)
  FROM world
  WHERE continent = 'Africa';

-- How many countries have an area of at least 1000000
SELECT COUNT(name)
  FROM world
  WHERE area >= 1000000;

-- What is the total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT SUM(population)
  FROM world
  WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

--


--


--


