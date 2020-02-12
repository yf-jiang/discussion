### simulate the distribution of a MLE
Simulation_number = 10000
DataList = map(1:Simulation_number,~rnorm(100,mean = 3,sd = 2))
###serially
mu_dist = rep(0,Simulation_number)
system.time({for(i in 1:length(DataList)){
  mu_dist[i] = DataList[[i]] %>% mean
}
})
###parLapply
library(parallel)
cl <- makeCluster(4)
system.time({mu_dist2 = parSapply(cl, DataList, mean)})
hist(mu_dist2)
stopCluster(cl)

###
session <- ssh_connect(
  "sta141c-98@peloton.cse.ucdavis.edu", 
  passwd = keyring::key_get("PELOTONPASSWORD"))
session %>% ssh_exec_wait("mkdir -p MLE")
session %>% scp_upload("Mu_dist.R",to = "MLE/")
