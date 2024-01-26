

percentZeros <- function(values){
  return((sum(values == 0) / length(values))*100)
}


extract.features <- function(rootPath, destPath, type="control"){
  
  info <- read.csv(paste0(rootPath,type,"-info.csv"))
  
  n <- nrow(info)
  
  all <- NULL # Data frame to store all users.
  
  for(i in 1:n){
    
    user <- info[i,]$number
    
    days <- info[i,]$days
    
    data <- read.csv(paste0(rootPath,type,"/",user,".csv"))
    
    dates <- unique(data$date)[1:days] # Only take first n days.
    
    for(d in dates){
      tmp <- data[data$date==d,]
      
      # Only keep entire days.
      if(nrow(tmp) < 1440){
        next
      }
      
      # Extract features.
      values <- tmp$activity
      
      f.mean <- mean(values)
      
      f.sd <- sd(values)
      
      f.pctZeros <- percentZeros(values)
     
      f.median <- median(values)
      
      f.q25 <- quantile(values, 0.25)
      
      f.q75 <- quantile(values, 0.75)
      
      
      instance <- data.frame(user=user,
                 mean=f.mean,
                 sd=f.sd,
                 pctZeros=f.pctZeros,
                 median=f.median,
                 q25=f.q25,
                 q75=f.q75,
                 class=type)
      all <- rbind(all,instance)
      
    }
    
  }
  
  # Save features.
  write.csv(all, paste0(destPath,type,"-features.csv"), row.names = F, quote = F)
  
}

merge.features <- function(path){
  
  data1 <- read.csv(paste0(path,"control-features.csv"))
  data2 <- read.csv(paste0(path,"depression-features.csv"))
  data3 <- read.csv(paste0(path,"schizophrenia-features.csv"))
  
  result <- rbind(data1, data2, data3)
  
  write.csv(result, paste0(path,"features.csv"), row.names = F, quote = F)
  
}