library(hydroGOF)
library(hydroTSM)

cimis_sub= read.csv("R:\\shared\\ETO\\ET0_Daymet\\EtExtract\\output\\Timeseries\\cimis_sub.csv")

# create subsets of daymet and cimis station data with only common stations 
ind = cimis_sub$X
daymet_sub <- cbind(data[names(data) %in% names(cimis_sub)])
#daymet_sub <- subset(daymet_sub, select = -Index )
daymet_sub <- daymet_sub[,order(colnames(daymet_sub))]
#Nondaymet_sub <- cbind(final[!names(final) %in% names(daymet_sub)])
#cimis_sub <- cbind(final[names(final) %in% names(daymet_sub)])
cimis_sub <-  cimis_sub[,-1]
cimis_sub <- cimis_sub[,order(colnames(cimis_sub))]


# calculate R2, RMSE, MAE,  PBIAS, NSE  
BR2 <- br2.data.frame(daymet_sub, cimis_sub, na.rm=TRUE)
RMSE <- rmse.data.frame(daymet_sub, cimis_sub, na.rm=TRUE)
mae <- mae.data.frame(daymet_sub, cimis_sub, na.rm=TRUE)
PBIAS <- pbias.data.frame(daymet_sub, cimis_sub, na.rm=TRUE)
NSE <- NSE.data.frame(daymet_sub, cimis_sub, na.rm=TRUE)
RESSQUARE = hydroGOF::ssq.data.frame (daymet_sub, cimis_sub, na.rm=TRUE)

#add calculated statistics to a matrix
statistics = cbind(BR2, RMSE, mae, PBIAS, NSE, RESSQUARE)
statistics = as.data.frame(statistics)

#plot Example station data in a graph, and report stas
plot2(cimis_sub$X15, daymet_sub$X15, plot.type = "single",
      tick.tstep = "auto", lab.tstep = "auto", lab.fmt=NULL,
      main="STA. 15. stratford Daymet cimis comparison (CIMIS Black, Daymet blue)", xlab = "time in days", ylab= "daymet simulation",
      cal.ini=NA, val.ini=NA, date.fmt="%Y-%m-%d",
      gof.leg = TRUE, gof.digits=2,
      gofs=c("ME", "MAE", "RMSE", "NRMSE", "PBIAS", "RSR", "rSD", "NSE", "mNSE",
             "rNSE", "d", "md", "rd", "r", "R2", "bR2", "KGE", "VE"),
      legend=TRUE, leg.cex = 1,
      col = c("black", "blue"),
      cex = c(0.5, 0.5), cex.axis=1.2, cex.lab=1.2,
      lwd= c(1,1), lty=c(1,3), pch = c(1, 9),
      pt.style = "ts", add = FALSE)

#write subsets to csv
#write.csv(cimis_sub, file = "C:\\Users\\Chadonnay\\Desktop\\Spring\\spring 2018\\cimis_sub.csv")
#write.csv(daymet_sub, file = "C:\\Users\\Chadonnay\\Desktop\\Spring\\spring 2018\\daymet_sub.csv")
#write.csv(statistics, file = "C:\\Users\\Chadonnay\\Desktop\\Spring\\spring 2018\\comparedstats.csv")
                           