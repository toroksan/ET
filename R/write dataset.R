file_names <- list.files('R:\\shared\\ETO\\ET0_Daymet\\EtExtract\\output\\Timeseries', full.names = T) #where you have your files

data = t(vector(mode = 'numeric', 584))
for (i in seq_along(file_names)){
  tmp = read.csv(file_names[i])
  tmp = tmp[,-1]
  data = cbind(tmp, data)
}
data = data[,order(colnames(data))]
test = data[,colnames(data )== 'X15']

test
write.csv(statistics, file = "summarystats_CIMISvalidation.csv",row.names=TRUE)
