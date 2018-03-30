path<-"C:/Users/Karthik/Downloads"
install.packages("h2o")
library(h2o)
h2o.init()
library(data.table)
xtrain=read.csv('X_train.csv',header = T)
xtrain=xtrain[,-1]
ytrain=read.csv('Y_train.csv',header = T)
xtest=read.csv('X_test.csv',header = T)
xtest=xtest[,-1]
head(xtest)
head(xtrain)
head(ytrain)
ytrain=ytrain[,-1]

joint=cbind(ytrain,xtrain)
head(joint)

split=r

datx = colnames(joint[,2:9])
daty = colnames(joint)
daty=daty[1]

trh=as.h2o(joint,destination_frame = "trh")
split=h2o.splitFrame(data = trh,ratios = 0.75)
train=split[[1]]
train=as.h2o(train)
test=split[[2]]
test=as.h2o(test)
head(train)
tjh=as.h2o(xtest,destination_frame="tth")


 model <-   h2o.deeplearning(x = datx,  # column numbers for predictors
                                           y = daty,   # column number for label
                                           training_frame = "trh",# data in H2O format
                                           activation = "RectifierWithDropout", # or 'Tanh'
                                           input_dropout_ratio = 0.3, # % of inputs dropout
                                           hidden_dropout_ratios = c(.4,0.4,0.2,0.2,0.2), # % for nodes dropout
                                           hidden = c(128,64,64,32,16), # three layers of 50 nodes
                                           epochs = 100, # max. no. of epochs
                                           standardize = T, 
                                           initial_weight_distribution = "Normal",verbose = F,
                                           stopping_metric="MSE", ## could be "MSE","logloss","r2"
                                           nfolds = 5,seed = 1,fold_assignment = 'Modulo',distribution = "gaussian",
                                          score_each_iteration=T,stopping_tolerance = 0.001,stopping_rounds = 3,
                                          l1=1e-5)
plot(model, 
          timestep = "epochs", 
          metric = "rmse") 
#which.min(training_rmse)

#hyper
hyper_params <- list(
  activation=c("RectifierWithDropout","TanhWithDropout","MaxoutWithDropout"),
  hidden=list(c(20,20,20,20),c(50,50,50,50),c(30,30,30,30),c(25,25,25,25),c(64,64,64,64),c(32,32,32,32),c(64,64,32,16)),
  input_dropout_ratio=c(0,0.1,0.3,0.2,0.05,0.15,0.25),
  l1=seq(0,1e-2,1e-6),
  l2=seq(0,1e-2,1e-6),
  hidden_dropout_ratios=list(c(0.4,0.3,0.3,0.3),c(0.25,0.25,0.25,0.25),c(0.35,0.35,0.35,0.35),c(0.5,0.5,0.5,0.5)))




search_criteria = list(strategy = "RandomDiscrete", max_runtime_secs = 360, max_models = 100, seed=1234567, stopping_rounds=5, stopping_tolerance=1e-2)

#training

model1 <-   h2o.grid(algorithm="deeplearning",x = datx,  # column numbers for predictors
                     y = daty,   # column number for label
                     training_frame = train,# data in H2O format
                     epochs = 100, # max. no. of epochs
                     standardize = T, 
                     initial_weight_distribution = "Normal" ,
                     stopping_metric="MSE", ## could be "MSE","logloss","r2"
                     nfolds = 10,seed = 1,fold_assignment = 'Modulo',distribution = "gaussian",
                     score_each_iteration=T,stopping_tolerance = 0.001,stopping_rounds = 3,
                     score_duty_cycle=0.025,         ## don't score more than 2.5% of the wall time
                     max_w2=10,                      ## can help improve stability for Rectifier
                     hyper_params = hyper_params,
                     search_criteria = search_criteria,grid_id = "model1")
grid <- h2o.getGrid("model1",sort_by="rmse",decreasing=FALSE)
grid


grid@summary_table[1,]
best_model <- h2o.getModel(grid@model_ids[[1]]) ## model with lowest logloss
best_model

?h2o
