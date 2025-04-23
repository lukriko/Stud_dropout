# Stud_dropout

This dataset is about predicting and exploring the student outcome based on several features like economic, marital, academic indicators and more.
Reference: https://www.kaggle.com/datasets/marouandaghmoumi/dropout-and-success-student-data-analysis/data


The goal of the exploration is to find out the key indicators having the most influence on the outcome, as well as splitting data and analyzing for each group being Graduate and Dropout.
# Steps of analyzing and predicting

1. analyzing data(EDA)
2. analyzing subsets(Graduate and Dropout)
3. Predictive modelling (applying ML algorithms and choosing the best one with highest accuracy)
4. The model follows supervised learning, therefore applying algorithms like: KNN, Logistic regression, decision trees, random forest, Naive bayes.
5. Model with the best accuracy

# Questions

##	How do grades differ between students who drop out and those who graduate?
    o	mean -- dropout < enrolled < Graduate
    o	standard deviation -- graduate < enrolled < dropout
    o	higher devation means more dispersion of the data from the mean -- which in this particular case might represent simple as well as dropout because of family matters
    o	variance -- graduate < enrolled < dropout


## What’s the relationship between parental qualifications and student success?

  o	-- for graduates
  o	        -- top five 27,14,1,28,3
  o	        -- bottom five 32,18,21,30,33
  
  o	-- for dropouts
  o	        -- top five 27,1,14,28,3
  o	        -- bottom five 19,23,13,22,31


  ## Do scholarship holders have a higher graduation rate?
    o	Yes. As the scholarship holders have higher graduation rate up to 76% while ,no scholarship students have graduation rate of 41.5%.
    
![scholarship](https://github.com/user-attachments/assets/5a72b0f7-e89d-4b59-a924-9c8b1618b69e)

##	How does marital status at enrollment affect dropout or success rates?
    o	Well, as the data showed the graduation rate is higher than dropout rate with marital status being 1.
    
##	How do international students with low parental education perform compared to locals with high parental education?
    o	Locals with higher parent qualification have higher graduation,enrollment and dropout rates,
      however international students with lower parental qualification have higher avg grades for both semesters for enrolled and graduates, 
      and lower avg for dropouts compared to locals.
