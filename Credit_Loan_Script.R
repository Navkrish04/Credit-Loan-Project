Train <- read.csv("Training_Credit_Loan_OverSampling_5.csv")
library(gbm)
GB <- gbm(formula = Train$SeriousDlqin2yrs ~ ., distribution = "adaboost", 
          data = Train, n.trees = 500, interaction.depth = 10, shrinkage = 0.05, 
          bag.fraction = 0.5, cv.folds = 3, keep.data = FALSE)
Test <- read.csv("Test_Credit_Loan.csv")

best.iter <- gbm.perf(GB,method="cv")

summary(GB, n.trees = best.iter)

Prediction_GB <- predict(GB, Test, type="response")

write.csv (Prediction_GB, file = "predict.csv", row.Names = FALSE)