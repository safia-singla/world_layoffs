-- Exploratory Data Analysis

SELECT * 
FROM world_layoffs.layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM world_layoffs.layoffs_staging2;

SELECT * 
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, sum(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

SELECT industry, sum(total_laid_off), AVG(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY 3 DESC;

SELECT country, sum(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`), sum(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

SELECT stage, sum(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT SUBSTRING(`date`, 1, 7) AS mnth, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY mnth
ORDER BY 1;

WITH Rolling_Total AS 
(
SELECT SUBSTRING(`date`, 1, 7) AS mnth, SUM(total_laid_off) AS total_off
FROM world_layoffs.layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY mnth
ORDER BY 1
)
SELECT mnth, 
SUM(total_off) OVER (ORDER BY mnth) as rolling_total, total_off
FROM Rolling_Total;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`);

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM CompanY_Year
WHERE years IS NOT NULL
ORDER BY years ASC
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;





























