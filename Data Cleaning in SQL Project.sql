-- DATA CLEANING

Select *
From layoffs;

-- 1. REMOVE DUPLICATES
-- 2. STANDARDISE THE DATA
-- 3. NULL VALUES OR BLANK VALUES
-- 4. REMOVE ANY COLUMNS

CREATE TABLE layoffs_staging
like layoffs;

Select *
From layoffs_staging;

Insert layoffs_staging
select *
from layoffs;

Select *
From layoffs_staging;

select *,
row_number() over(
Partition by company, industry, total_laid_off, percentage, 'date') as row_num
from layoffs_staging;


WITH Duplicate_cte as
(
select *,
row_number() over(
Partition by company, location, industry, total_laid_off, percentage, 'date', funds_raised, stage, country) as row_num
from layoffs_staging
)
select * 
from duplicate_cte
where row_num > 1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage` text,
  `date` text,
  `funds_raised` double DEFAULT NULL,
  `stage` text,
  `country` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2;

Insert into layoffs_staging2
select *,
row_number() over(
Partition by company, location, industry, total_laid_off, percentage, 'date', funds_raised, stage, country) as row_num
from layoffs_staging;

DELETE
from layoffs_staging2
where row_num > 1; 

select * 
from layoffs_staging2
where row_num =2; 
 
select * 
from layoffs_staging2;

-- STANDARDISING DATA

SELECT company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

SELECT distinct industry
from layoffs_staging2
order by 1;

SELECT *
from layoffs_staging2
where industry like 'crypto%';

SELECT distinct country
from layoffs_staging2
order by 1;

select *
from layoffs_staging2;

SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
Modify column `date` date;

update layoffs_staging2
set industry = null
Where industry = '';

select *
from layoffs_staging2
where industry is null
or industry = '';

select * 
from layoffs_staging2
where company = 'AvantStay';

update layoffs_staging2
set industry = NULL
Where industry = '';

select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is NOT null;

update layoffs_staging2 t1
join layoffs_staging t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;

select * 
from layoffs_staging2
Where industry = '';

select *
from layoffs_staging2
where industry is null
or industry = '';

SELECT location, industry, COUNT(*) as row_count
FROM layoffs_staging2
WHERE industry IS NULL OR industry = ''
GROUP BY location, industry
ORDER BY row_count DESC;

SELECT DISTINCT location, industry
FROM layoffs_staging2
WHERE industry IS NOT NULL AND industry != ''
ORDER BY location;


UPDATE layoffs_staging2 SET industry = 'Construction' WHERE company = 'AvantStay';
UPDATE layoffs_staging2 SET industry = 'Database' WHERE company = 'InfluxData';  
UPDATE layoffs_staging2 SET industry = 'Logistics' WHERE company = 'Exodus';

SELECT location, industry, COUNT(*) 
FROM layoffs_staging2 
GROUP BY location, industry
ORDER BY COUNT(*) DESC;

SELECT *
FROM layoffs_staging2
ORDER BY date DESC;


delete
from layoffs_staging2
where total_laid_off is null
and percentage is null;

select *
from layoffs_staging2;

alter table layoffs_staging2
drop row_num;













