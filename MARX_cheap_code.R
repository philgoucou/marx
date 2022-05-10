X = something
n_lag = 12
n_var = ncol(X)
library(vars)

var = VAR(X, p = n_lag, type = "const")

# extract data matrix for VAR
matata = as.matrix(var$datamat)
mat_y = matata[,1:n_var]
mat_x = matata[,-c(1:n_var)]

#ex-ante scaling, may be desirable in certain applications, otherwise comemnt out
mat_y = as.matrix(scale(mat_y))
mat_x = as.matrix(scale(mat_x))

mat_x_marx = mat_x
for(l in 2:n_lag){
  for(v in 1:n_var){
    whotoavg=seq(from=v,to=n_var*(l-1)+v,by=n_var)
    mat_x_marx[,n_var*(l-1)+v]=apply(mat_x[,whotoavg],1,mean)
  }}

colnames(mat_x_marx)=paste('MARX_',colnames(mat_x),sep='')