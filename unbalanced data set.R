#------ using oversampling since medulloblastoma variable is unbalanced.
train_over <- ovun.sample(dead~., data = train, method = "over")$data #, N = 432
prop.table(table(train_over$dead)) 
test_over <- ovun.sample(dead~., data = test, method = "over")$data
prop.table(table(test_over$dead))