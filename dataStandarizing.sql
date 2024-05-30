select * from layoffs_staging2;

select distinct(industry) from layoffs_staging2 order by 1;

select * from layoffs_staging2 where industry like 'Crypto%';

update layoffs_staging2 set industry = 'Crypto' where industry like 'Crypto%';   -- instead of  in ('Crypto','Crypto Currency');

select trim(industry) from layoffs_staging2;

select distinct country, trim(trailing '.' from country) from layoffs_staging2 order by 1;

update layoffs_staging2 set country ='United States' where country="United States.";

select `date`, str_to_date(`date` ,'%m/%d/%Y') from layoffs_staging2;

select date from layoffs_staging2;

update layoffs_staging2 set `date`=str_to_date(`date` ,'%m/%d/%Y');

desc layoffs_staging2;

alter table layoffs_staging2 modify column `date` date;




-- dealing with nulls and blank spaces
select * from layoffs_staging2 where total_laid_off is null and percentage_laid_off is null;
delete from layoffs_staging2 where total_laid_off is null and percentage_laid_off is null;

select * from layoffs_staging2 where industry is null or industry='';
select * from layoffs_staging2 where company='Airbnb';

select distinct industry from layoffs_staging2 ;

update layoffs_staging2 set industry=NUll where industry ='';

select * from 
layoffs_staging2 t1 join  layoffs_staging2 t2 
on t1.company=t2.company and t1.location=t2.location
where t1.industry is null
and t2.industry is not null;


update layoffs_staging2 t1 join  layoffs_staging2 t2 
on t1.company=t2.company 
set t1.industry=t2.industry
where t1.industry is null
and t2.industry is not null;

alter table layoffs_staging2 drop column rowNUM;

select * from layoffs_staging2;
