#-------------- XGBoost
# first model with default parameters.
params <- list(booster = "gbtree", 
               objective = "binary:logistic",
               eta=0.0001, 
               gamma=0, 
               max_depth=6, 
               min_child_weight=1, 
               subsample=1, 
               colsample_bytree=1)
xgbcv  <- xgb.cv(params = params, 
                 data = dtrain, 
                 nrounds =500, 
                 nfold = 10, 
                 showsd = T, 
                 stratified = T, 
                 print_every_n = 10,
                 early_stop_rounds = 20, 
                 maximize = F)
min(xgbcv$evaluation_log$test_logloss_mean) #round500

# first default - model training
xgb1 <- xgb.train(params = params, 
                  data = dtrain, 
                  nrounds =500, 
                  watchlist = list(val=dtest,train=dtrain), 
                  print_every_n = 10, 
                  early_stop_rounds = 20, 
                  maximize = F , 
                  eval_metric = "auc")

#------- model prediction
xgbpred <- predict (xgb1,dtest)
xgbpred <- ifelse (xgbpred > 0.5,1,0)


#----------print(importance)

importance <- xgb.importance(model = xgb1)
print(importance)
ppp= xgb.plot.importance(importance_matrix = importance, measure = "Cover")
#------- confusion matrix
c<-confusionMatrix (as.factor(xgbpred), as.factor(ts_label))