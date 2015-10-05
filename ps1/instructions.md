_Problem set instructions and variable descriptions by Prof. David Kaplan._

***

## Problem Set 1: Path Analysis

For this problem set, you are asked to estimate and test a path analysis model
for reading literacy. The data come from the OECD/Programme for International
Student Assessment (PISA).

PISA focuses on young people’s ability to use their knowledge and skills to meet
real-life challenges. This orientation reflects a change in the goals and
objectives of curricula themselves, which are increasingly concerned with what
students can do with what they learn at school and not merely with whether they
have mastered specific curricular content. PISA’s unique features include its:

* Policy orientation, which highlights differences in performance patterns and
  identifies features common to high-performing students, schools and education
  systems by linking data on learning outcomes with data on student
  characteristics and other key factors that shape learning in and outside of
  school.
* Innovative concept of “literacy”, which refers both to students’ capacity to
  apply knowledge and skills in key subject areas and to their ability to analyse,
  reason and communicate effectively as they pose, interpret and solve problems in
  a variety of situations.
* Relevance to lifelong learning, which goes beyond assessing students’
  competencies in school subjects by asking them to report on their motivation to
  learn, their beliefs about themselves and their learning strategies.
* Regularity, which enables countries to monitor their progress in meeting key
  learning objectives.

* Breadth of geographical coverage and collaborative nature, which, in PISA
  2009, encompasses the 34 OECD member countries and 41 partner countries and
  economies.

The data come from the US sample of PISA 2009 (N = 5,233). For the
write-up, please address the following issues.

1. Provide three indications that the model in the Figure is identified. 
2. Using summary statistics programs in R, determine if the data meet the
   assumptions of multivariate normality. Provide evidence to support your
   conclusion. Note that missing data are coded 9999. Please use listwise deletion.
3. Estimate the model using ML. Compute all indirect and total effects in the
   model.
4. Provide evidence of the fit (or lack thereof) of the model.
5. Modify the model using the modification indices and expected parameter change
   statistics. Justify the modification on substantive grounds. (I recognize that
   this is not your data – make something up that is sensible).
6. Choose a final model based on the BIC.
7. Provide a full discussion of the substantive conclusions based on the model,
   including model fit and interpretation of the significant direct, indirect, and
   total effects in the model.
8. Please provide a write-up in the form of a “methods”, “results”, and
   “discussion” section in a style consistent with your major field (e.g. APA).

## Variable Descriptions

**ESCS**: The PISA index of economic, social and cultural status (ESCS) was
derived from the following three indices: highest occupational status of parents
(HISEI), highest educational level of parents in years of education according to
ISCED (PARED), and home possessions (HOMEPOS). The index of home possessions
(HOMEPOS) comprises all items on the indices of WEALTH, CULTPOSS and HEDRES, as
well as books in the home recoded into a four-level categorical variable (0-10
books, 11-25 or 26-100 books, 101-200 or 201-500 books, more than 500 books).

The PISA index of economic, social and cultural status (ESCS) was derived from a
principal component analysis of standardized variables (each variable has an
OECD mean of zero and a standard deviation of one), taking the factor scores for
the first principal component as measures of the index of economic, social and
cultural status.

The final values on the PISA index of economic, social and cultural status
(ESCS) have an OECD mean of 0 and a standard deviation of 1.

**Gender**: it is coded to have 1 if female and 0 if male. 

**Immig**: The index on immigrant background (IMMIG) is coded to have 1 if
either (2) second-generation students (those born in the country of assessment
but whose parents were born in another country) or (3) first-generation students
(those born outside the country of assessment and whose parents were also born
in another country), and to have 0 if native students (those students born in
the country of assessment, or those with at least one parent born in that
country; students who were born abroad with at least one parent born in the
country of assessment are also classified as ‘native’ students).

**Reading**: The final outcome variable is an estimate of reading competency.
Higher values indicate higher levels of reading competency.

### Approaches to learning

How students approach learning is based on student responses in ST27 and
measured through the following three indices:

- memorisation (MEMOR)
- elaboration (ELAB)
- control strategies (CSTRAT)

The index of memorisation (**MEMOR**) was derived from the frequency with which
students did the following when they were studying: 

1. try to memorise everything that is covered in the text
2. try to memorise as many details as possible
3. read the text so many times that they can recite it
4. read the text over and over again

The index of elaboration (**ELAB**) was derived from the frequency with which
students did the following when they were studying:

1. try to relate new information to prior knowledge acquired in other subjects
2. figure out how the information might be useful outside school
3. try to understand the material better by relating it to my own experiences 
4. figure out how the text information fits in with what happens in real life

The index of control strategies (**CSTRAT**) was derived from students’ reports
on how often they did the following statements when studying:

1. I start by figuring out what exactly I need to learn
2. I check if I understand what I have read
3. I try to figure out which concepts I still haven’t really understood
4. I make sure that I remember the most important points in the text
5. when I don’t understand something, I look for additional information to clarify 
   this

Higher values on each index indicate higher importance attached to the given
strategy.

