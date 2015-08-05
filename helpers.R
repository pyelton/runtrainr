#load("./rf_model_072315.RData")
#load("./enspls_model_app_073115.RData")
library(stats)
library(enpls)

###########ens_pls_model
model <- function(vals){
    names(vals) = c("YTD_Runs", "X5K", "mnth_ELEVATION", 
                      "mnth_pace1", "weight", 
                      "minp", "gender","YTD_Distance")
    vals$minp <- vals$minp*60
    vals$mnth_pace1 <- vals$mnth_pace1*60
    vals$X5K <- vals$X5K*60
    p = predict(enpls.final, newdata = vals)
    hours <- as.integer(p/60)
}

##########How can you improve your time
improve <- function(vals, time){
    names(vals) = c("YTD_Runs", "X5K", "mnth_ELEVATION", 
                    "mnth_pace1", "weight", 
                    "minp", "gender","YTD_Distance")
    vals$mnth_pace1 <- vals$mnth_pace1*60
    vals$X5K <- vals$X5K*60
    vals$minp <- (vals$minp - 1) * 60
    vals$YTD_Distance <- vals$YTD_Distance * 365/2
    vals$YTD_Runs <-  vals$YTD_Runs * 365/2
    p_new = predict(enpls.final, newdata = vals)/60
}
