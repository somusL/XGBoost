#####ROC###################
pre_xgb =  round(predict(xgb1,newdata = dtest)) 
table(pre_xgb,ts_label,dnn=c("pre","true"))
#Tt_label<- as.numeric(test$metastasis)-1
xgboost_roc <- roc(ts_label,as.numeric(pre_xgb))
pp=plot(xgboost_roc, print.auc=TRUE, auc.polygon=F, grid=c(0.1, 0.2),grid.col=c("green", "red"), max.auc.polygon=F,auc.polygon.col="NA", print.thres=T,main='ROC curve')