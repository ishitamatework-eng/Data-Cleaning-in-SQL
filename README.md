# Data-Cleaning-in-SQL
## Project Objective
Analyze 2020-2022 company layoff patterns by industry, location, funding stage, and employee count to identify business trends and risk factors. Clean raw CSV data (823 messy rows) into production-ready analytics table for actionable business insights and executive reporting.
## Dataset used
- <a href="https://github.com/ishitamatework-eng/Data-Cleaning-in-SQL/blob/main/layoffs.csv">Dataset</a> 
## Data Cleaning Process
- Loaded raw layoffs.csv (823 messy rows) into layoffs_staging2 table
- Removed 29 duplicates using ROWID + company/date/location grouping (823 → 794 rows)
- Standardized dates (STR_TO_DATE MM/DD/YYYY → YYYY-MM-DD format)
- Fixed 15.5% NULL industries (manual: AvantStay=Construction; location logic: SF Bay=Tech)
- Unified locations ("SF Bay" → "SF Bay Area", "New York" → "New York City")
- Dropped invalid rows (layoffs >50k, percentage >100%) + unused columns
- Verified 0% NULLs/duplicates across 9 clean columns
- <a href="https://github.com/ishitamatework-eng/Data-Cleaning-in-SQL/commit/7278fbf17f1d05d9b8e271eb8901caac655dd252">View Project</a>
## Project Outcome
Delivered clean, scalable analytics dataset from raw layoffs data—perfect foundation for business analytics use cases like industry benchmarking, geographic risk assessment, and funding-stage performance analysis. Transformed data chaos into strategic insight engine.
