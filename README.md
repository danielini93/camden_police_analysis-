# camden_police_analysis-
SQL analysis of police stop data 
/*
================================================================================
CAMDEN POLICE ANALYSIS - SQL QUERIES
================================================================================
Dataset: The Stanford Open Policing Project
File: nj_candem_2020_04_01.csv
Analysis: Which vehicles are most prone to being stopped?
Special Mention: E. Pierson, C. Simoiu, J. Overgoor, S. Corbett-Davies, D. Jenson, A. Shoemaker, 
V. Ramachandran, P. Barghouty, C. Phillips, R. Shroff, and S. Goel. “A large-scale analysis of racial disparities 
in police stops across the United States”. 
Nature Human Behaviour, Vol. 4, 2020.


QUERIES PROGRESSION:
1. Basic exploration (SELECT, COUNT, LIMIT)
2. Filtering (WHERE clause)
3. Grouping & aggregation (GROUP BY, COUNT)
4. Sorting & percentages (ORDER BY, calculations)
5. Complex analysis (combinations, subqueries)

Author: Daniel
Date: April 20, 2026
-- ============================================================================
-- KEY FINDINGS SUMMARY
-- ============================================================================

FINDINGS FROM QUERIES:

1. COLOR DISTRIBUTION:
   - BLACK vehicles are stopped most frequently (~25%)
   - SILVER vehicles are second (~17%)
   - Shows clear color preferences in stops

2. MAKE DISTRIBUTION:
   - HONDA is most commonly stopped (~21%)
   - CHEVROLET is second (~14%)
   - Shows brand dominance in stops

3. MODEL DISTRIBUTION:
   - HONDA ACCORD is most stopped (~8%)
   - HONDA CIVIC is second (~5%)
   - Shows model-level patterns

4. COMBINED FINDINGS:
   - BLACK HONDA ACCORD is most common combination (~7%)
   - Multiple factors combine to create patterns

5. WHAT WE DON'T KNOW:
   - WHY these vehicles are stopped more
   - Whether it's popularity or targeting
   - Would need vehicle registration data to compare
   - Would need crime statistics for context

SKILLS DEMONSTRATED:
✅ SELECT for data retrieval
✅ WHERE for filtering
✅ GROUP BY for aggregation
✅ COUNT for counting records
✅ ROUND for formatting
✅ ORDER BY for sorting
✅ LIMIT for result limitation
✅ Calculations (percentages)
✅ NULL value handling
✅ Multiple column grouping
✅ COUNTIF for conditional counting
✅ Window functions (SUM() OVER())
✅ Comments and documentation
