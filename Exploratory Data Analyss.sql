-- Exploratory Data Analysis
select * from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off) from layoffs_staging2;

select * from layoffs_staging2 where percentage_laid_off =1 order by funds_raised_millions desc;

select company, sum(total_laid_off) as su from layoffs_staging2 group by company order by 2 desc;

select min(`date`), max(`date`) from layoffs_staging2;

select industry, sum(total_laid_off) as su from layoffs_staging2 group by industry order by 2 desc;

select country, sum(total_laid_off) from layoffs_staging2 group by country order by 2 desc;

select Year(`date`), sum(total_laid_off) from layoffs_staging2 group by Year(`date`) order by 1;

select substring(`date`,6,2) as `month`, sum(total_laid_off) from layoffs_staging2 group by `month` order by 1 ;

select substring(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_staging2 
where substring(`date`,1,7) is not null 
group by `month` order by 1;

with rollingTotal as(
select substring(`date`,1,7) as `month`, sum(total_laid_off) as ssum from layoffs_staging2 where substring(`date`,1,7) is Not Null group by `month`)
select `month`,ssum, sum(ssum) over(order by `month`) as totalSum from rollingTotal;

select company,Year(`date`), sum(total_laid_off) from layoffs_staging2 group by Company, Year(`date`) order by 3 desc;


with ranking as (
select company,Year(`date`) as Years, sum(total_laid_off) as total_laid_off from layoffs_staging2 group by Company, Year(`date`) ),
company_year_rank as(
select *, dense_rank() over(partition by years order by total_laid_off desc) as denseRanking from ranking where years is not null)
select * from company_year_rank where denseRanking <=5;
