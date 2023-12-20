#######check correlation
p<-model.matrix(~0+., data=cdata) %>% 
  cor(use="pairwise.complete.obs") %>% 
  ggcorrplot(show.diag = T, type="lower", lab=TRUE, lab_size=2) #check correlation
p

ggsave(p, filename = "corplot.pdf", device = 'pdf', width = 26, height = 20, units = 'cm')

#ggpairs(cdata, title = "correlogram with MB")