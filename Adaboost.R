# convert data frame to data table.
setDT(train_over) 
setDT(test_over)
# ---------- Adaboost
train_over_1<-train_over
train_over_1$dead<-revalue(train_over_1$dead, c("no"="0", "yes" ="1"))
test_1<-test_over
test_1$dead<-revalue(test_1$dead, c("no"="0", "yes" ="1"))
model = boosting(dead~., data = train_over_1 , boos = TRUE, mfinal =100) #100 iterations
pred.adaboost = predict(model , test_1)
pred.adaboost$confusion
pred.adaboost$error # accuracy

# confustion matrix
library(tibble)
library(cvms)
cm_ada<-as_tibble(pred.adaboost$confusion)
cm_ada_1<-plot_confusion_matrix(cm_ada, target_col = "Observed Class", prediction_col = "Predicted Class",counts_col = "n")
cm_ada_1

#--------- data preparation for XGBoost
# one hot encoding for all categorical variables.
labels <- train_over$dead
ts_label <- test_over$dead
new_tr <- model.matrix(~.+0,data = train_over[,-c("dead"),with=F]) 
new_tr

new_ts <- model.matrix(~.+0,data = test_over[,-c("dead"),with=F])
new_ts
# convert factor to numeric 
labels <- as.numeric(labels)-1
ts_label <- as.numeric(ts_label)-1

# preparing matrix 
dtrain <- xgb.DMatrix(data = new_tr,label = labels) 
dtest <- xgb.DMatrix(data = new_ts,label=ts_label)