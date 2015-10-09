_Problem set instructions by Prof. David Kaplan. The codebook is in
`data/ps3_codes.yml`. See variable descriptions from problem set 1._

***

## Problem Set 3: Missing Data

For this assignment, please conduct the following set of analyses:

1. Read in the data and code missing as NA. For these data, missing is blank in
   the .csv file. To recode as `NA`, type `dataname[dataname == ""] <- NA`.
2. Conduct ML factor analysis on the endogenous constructs. Present the results,
   but do not modify the model. Use the MLR estimator and FIML for handling 
   missing data.
3. Conduct a full SEM based on the initial model specification shown in the path
   diagram. Use MLR and FIML to handle the missing data. Make a note of the fit 
   of the model.
4. Inspect modification indices for any structural paths that could be freed.
5. Re-estimate the model based on the modification indices and present the
   findings, including interpretations of the structural parameters. This would 
   be your final model.
6. For comparison purposes, please re-estimate your final model in #5 using
   WLSMV for the categorical variables and compare to MLR. Note changes to the 
   fit and the standard errors.
7. Also for comparison purposes, please re-estimate your final model in #5 using
   MLR and multiple imputation with “pmm”. Make a note about differences in
   estimates, standard errors and goodness-of-fit compared to the results in #5.
8. Write-up the findings in a manner consistent with the publication style in
   your field. To be clear, please present a full narrative write-up that covers 
   steps 1-7. Don’t answer 1-7 and then provide a write-up.
