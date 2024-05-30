-- deleting duplicate date
create table layoffs_staging like layoffs;

select * from layoffs_staging;

insert into layoffs_staging  select * from layoffs;

select *, row_number() over(
partition by country, industry, total_laid_off, percentage_laid_off, `date`) as rowNUM
from layoffs_staging;


with duplicateCTE as(
select *, row_number() over(
partition by country,company, location, industry, total_laid_off, percentage_laid_off, `date`,stage,funds_raised_millions) as rowNUM
from layoffs_staging
)
select * from duplicateCTE where rowNUM>1;

select * from layoffs_staging where company ='oda';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `rowNUM` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select * from layoffs_staging2;

insert into layoffs_staging2 
select *, row_number() over(
partition by company,location, industry, total_laid_off, percentage_laid_off, `date`,stage,country,funds_raised_millions) as rowNUM
from layoffs_staging;

select * from layoffs_staging2 where rowNUM>1;
