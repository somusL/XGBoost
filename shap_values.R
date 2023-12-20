shap_values = shap.values(xgb1, X_train= new_ts)
shap_values$mean_shap_score #calculate from shap_values$shap_score for each row in test_matrix

# To prepare the long-format data(convert dgCMatrix to matrix):
shap_long <- shap.prep(xgb1, X_train = new_ts,top_n=20)
# SHAP summary plot
plot1<-shap.plot.summary(shap_long)

# dependence plot  
plot2<-shap.plot.dependence(data_long = shap_long, x= "histologylca",color_feature = "SexMale")
#plot2<-shap.plot.dependence(data_long = shap_long, x= "subgroupgroup4",color_feature = "SexMale")
#plot2<-shap.plot.dependence(data_long = shap_long, x= "subgroupgroup4_alpha",color_feature = "SexMale")
#plot2<-shap.plot.dependence(data_long = shap_long, x= "subgroupgroup4_beta",color_feature = "SexMale")
#plot2<-shap.plot.dependence(data_long = shap_long, x= "agegroup0-3",color_feature = "SexMale")

importance <- xgb.importance(model = xgb3)
print(importance)
xgb.plot.importance(importance_matrix = importance)