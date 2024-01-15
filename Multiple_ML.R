library(treesnip)
library(tidymodels)
library(baguette)
library(discrim)
library(treesnip)

#bb<-  SMOTE(dead ~., perc.over = 200, perc.under =150, data =aa)

#aa$labels <- as.factor(aa$labels)
#bb$labels <- as.factor(bb$labels)


rec <- recipe(labels~.,aa)


# XGBoost
xgb_mod <- boost_tree() %>%           
  set_engine("xgboost") %>%           
  set_mode("classification")
     
# 决策树
dt_mod <- decision_tree() %>%           
  set_engine("rpart") %>%           
  set_mode("classification")
  
# 逻辑回归
logistic_mod <-          
  logistic_reg() %>%          
  set_engine('glm')
     
# nnet
nnet_mod <-          
  mlp() %>%          
  set_engine('nnet') %>%          
  set_mode('classification')
  
 # 朴素贝叶斯        
naivebayes_mod <-          
  naive_Bayes() %>%          
  set_engine('naivebayes')
               
#KNN
kknn_mod <-          
  nearest_neighbor() %>%          
  set_engine('kknn') %>%          
  set_mode('classification')
  
# 随机森林
rf_mod <-          
  rand_forest() %>%          
  set_engine('ranger') %>%          
  set_mode('classification')
  
# SVM        
svm_mod <-          
  svm_rbf() %>%          
  set_engine('kernlab') %>%          
  set_mode('classification')
  

#lightgbm
lightgbm_mod <-boost_tree() %>%
  set_engine('lightgbm')%>%
  set_mode('classification')

#C5.0
C5.0_mod <-bag_tree() %>%
  set_engine('C5.0')%>%
  set_mode('classification')

wf <- workflow_set(preproc=list(rec),          
                        models=list(xgb=xgb_mod,          
                        dt=dt_mod,          
                        log= logistic_mod,          
                        nb=naivebayes_mod,          
                        nnet=nnet_mod,          
                        knn=kknn_mod,         
                        svm=svm_mod,
                        C5.0=C5.0_mod
                        ))       
wf


# 设置重采样
folds <- bootstraps(aa,10)
# 控制条件，保存预测值      
ctr <- control_resamples(save_pred = TRUE)
# 模型拟合 
wf_res <- wf %>% 
  workflow_map("fit_resamples", #重采样拟合
               resamples=folds, # 重采样 
               control=ctr)
# 拟合结果
wf_res



rank_results(wf_res,rank_metric = "roc_auc") %>% 
  filter(.metric=="roc_auc") %>% 
  select(model,mean)


autoplot(wf_res) # Accuracy和AUC




























