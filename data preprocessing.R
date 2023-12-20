rm(list=ls())
#----------- data preprocessing 

MB <- read.table("MB_763.txt",header=T,sep="\t",row.names=1)

#data<- MB[,-c(2)]

set.seed(1991)
cdata<- MB[sample(nrow(MB), 432), ]
prop.table(table(cdata$dead))#unbalaced response variable (same ratio with original data)
cdata$dead <- as.factor(cdata$dead)
cdata$agegroup <- as.factor(cdata$agegroup)
cdata$histology <- as.factor(cdata$histology)
cdata$metastasis <- as.factor(cdata$metastasis)
cdata$subgroup <- as.factor(cdata$subgroup)
cdata$subtype <- as.factor(cdata$subtype)
cdata$gender <- as.factor(cdata$gender)

data <- ROSE(dead ~ ., data = cdata, seed = 1991)$cdata
table(cdata$dead)


sum(is.na(cdata)) #no missing values


str(cdata) #check again