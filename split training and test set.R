#---------- split training and test set.
set.seed(1991)

trainIndex<- createDataPartition(cdata$dead, p = 0.7, 
                                 list = FALSE, 
                                 times = 1)
train <- cdata[ trainIndex,]
test  <- cdata[-trainIndex,]


#train_1 <- cdata[ trainIndex,]
#test_1  <- cdata[-trainIndex,]
#test <-test_1
#train<-  SMOTE(dead ~., perc.over = 200, perc.under =150, data = train_1)
#test  <-  SMOTE(dead ~., perc.over = 200, perc.under =150, data = test_1)