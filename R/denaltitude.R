denaltitude=function(airportCode,elevation="ft"){
  suppressMessages(require(pmetar))
  suppressMessages(require(airportr))
  defaultW <- getOption("warn")
  options(warn = -1)
  airportDF <- as.data.frame(airportr::airport_detail(airportCode))
  apAlt <- airportDF$Altitude
  reMetar <- suppressMessages(pmetar::metar_get(airport=airportCode))
  presLoc <- 999
  if (reMetar[1] == "No METAR found!") {reMetar[1]} else {
    reMetar <- unlist(strsplit(reMetar," "))
    for (j in 1:length(reMetar)) {
      ifelse(substr(reMetar[j],1,1)=="A",ifelse(nchar(reMetar[j])==5,presLoc<-j,""),"")
      if(presLoc == j){break}
    }
    presVec <- unlist(strsplit(reMetar[presLoc],"A"))
    presHg <- strtoi(presVec[2])/100
    for (i in 1:length(reMetar)) {
      ifelse(grepl("/",reMetar[i])==TRUE,ifelse(nchar(reMetar[i])<=7,tempLoc<-i,""),"")
    }
    tempVec <- unlist(strsplit(reMetar[tempLoc],"/"))
    tempC <- strtoi(tempVec[1])
    presAlt<- (29.92-presHg)*1000+apAlt
    denAlt <- presAlt+118.8*(tempC-13.39)
    ifelse(elevation=="m",apAlt<-apAlt/3.281,"")
    ifelse(elevation=="m",denAlt<-denAlt/3.281,"")
    cat("City =",airportDF$City,":",airportDF$Country,"\n")
    cat("Airport Altitude =",round(apAlt,0),elevation,"\n")
    cat("Density Altitude =",round(denAlt,0),elevation,"\n")
    options(warn = defaultW)
  }
}
