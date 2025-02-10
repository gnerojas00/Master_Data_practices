SELECT Year FROM Gn.suiciderate;

# ¿Cuál es la tasa de suicidio promedio por país?

SELECT CountryName, AVG(SuicideCount) AS AvgSuicideRate
FROM Gn.suiciderate
GROUP BY CountryName
ORDER BY AvgSuicideRate DESC;

# ¿Cuál ha sido el año con la tasa de suicidio más alta en cada país?

select CountryName, Year, SuicideCount
from Gn.suiciderate
WHERE (CountryName, SuicideCount) IN (
select CountryName, MAX(SuicideCount)
from Gn.suiciderate
group by CountryName
);

#¿Diferencia en la tasa de suicidios entre hombres y mujeres totales?

Select Sex, SUM(SuicideCount) as TotalSuicidios
from Gn.suiciderate
group by Sex;

#¿Qué países tienen la tasa de suicidio más alta en relación con su población?

Select CountryName, SUM(SuicideCount)/sum(Population) * 100 as ProporcionSuicidios
from Gn.suiciderate
group by CountryName
ORDER BY ProporcionSuicidios desc
LIMIT 10;

#¿Cómo ha cambiado la tasa de suicidios en un país específico a lo largo del tiempo?

select CountryName, Year, sum(SuicideCount) AS SuicidiosTotales
from Gn.suiciderate
where CountryName = 'Spain'
group by Year;

select CountryName, SuicideCount, Year
from Gn.suiciderate
where CountryName like '%zuela%';

select CountryName, Year, sum(SuicideCount) AS SuicidiosTotales
from Gn.suiciderate
where CountryName = 'Venezuela (Bolivarian Republic of)'
group by Year;

#¿Qué regiones tienen la mayor tasa de suicidio en promedio?

Select RegionName, SUM(SuicideCount) as TotalSuicidios, SUM(SuicideCount)/SUM(Population) as ProporcionSuicidios
from Gn.suiciderate
group by RegionName
order by ProporcionSuicidios desc;

#otro archivo - archivo_ratesuic

select * 
from Gn.archivo_ratesuic
limit 10;


#obtener el numero de suicidios cuando ocurria la tasa de inflacion mas alta en cada pais

select A.CountryName, A.Year, A.InflationRate, B.Totalsuicide
from Gn.archivo_ratesuic A 
JOIN 
(select CountryName, MAX(InflationRate) MaxInflation, SUM(SuicideCount) as Totalsuicide
from Gn.archivo_ratesuic
group by CountryName) B 
ON A.CountryName=B.CountryName and B.MaxInflation=A.InflationRate
group by A.CountryName, A.Year
order by InflationRate desc;

#¿Cómo ha cambiado la tasa de suicidios en relación con la tasa de empleo?

SELECT A.CountryName, A.Year, A.SuicideCount as Suicidiostotales, A.EmploymentPopulationRatio as TasapromediodeEmpleo
from Gn.archivo_ratesuic A
JOIN
(
select CountryName, MAX(SuicideCount) as Suicidiostotales
from Gn.archivo_ratesuic
group by CountryName
) B on 
A.CountryName = B.CountryName and A.SuicideCount = B.Suicidiostotales;

#¿Cómo ha cambiado la tasa de suicidios en relación con la tasa de empleo e inflacion en Alemania?

select Year, avg(EmploymentPopulationRatio), avg(InflationRate)
from Gn.archivo_ratesuic
where CountryName = 'Germany'
group by Year;

#¿A;os en donde hubo mayor y menor tasa de suicidios, reflejando la tasa de empleo e inflacion en Alemania?

select A.CountryName, A.Year, A.SuicideCount, A.EmploymentPopulationRatio, A.InflationRate
from Gn.archivo_ratesuic A 
JOIN (
select CountryName, MAX(SuicideCount) as maxsuiciderate
from Gn.archivo_ratesuic
group by CountryName
 ) B
 ON A.CountryName=B.CountryName and A.SuicideCount=B.maxsuiciderate;
 
 select CountryName,  MIN(SuicideCount) as minsuicide
 from Gn.archivo_ratesuic 
 where (SuicideCount > 0 and CountryName IN ('Japan', 'Germany', 'Spain'))
 group by CountryName;
 
 #datos generales
 #cuantas regiones hay ene el data set? cuantos paises integran cada region?
 select RegionName, count(Distinct CountryName)
 from Gn.archivo_ratesuic 
 Where CountryName IN ( select distinct CountryName
 from Gn.archivo_ratesuic)
 group by RegionName;
 
 #same but really more easy
 
select RegionName, count(Distinct CountryName)
from Gn.archivo_ratesuic 
group by RegionName;
 
 
#Hombres y mujeres por cada region en cuanto a su poblacion total para 2010
 
 select RegionName, Sex, sum(Population)
 from Gn.archivo_ratesuic 
 where Year = 2010
 group by RegionName, Sex;
 



 
 






