denaltitude=function(airportCode,elevation="ft"){
  suppressMessages(require(pmetar))
  suppressMessages(require(airportr))
  defaultW <- getOption("warn")
  options(warn = -1)
  airportDF <- as.data.frame(airportr::airport_detail(airportCode))
  apAlt <- airportDF$Altitude
  presVec <- c(NA)
  tempVec <- c(NA)
  reMetar <- suppressMessages(pmetar::metar_get(airport=airportCode))
  if (reMetar[1] == "No METAR found!") {reMetar[1]} else {
    reMetar <- unlist(strsplit(reMetar," "))
    for (j in 1:length(reMetar)) {
      if (substr(reMetar[j],1,1)=="A") {
        if (nchar(reMetar[j])==5) {
          presVec <- strtoi(unlist(strsplit(reMetar[j],"A"))[2])/100
        }  
      }    
      if (grepl("/",reMetar[j])==TRUE) {
        if (nchar(reMetar[j])<=7) {
          tempVec <- strtoi(unlist(strsplit(reMetar[j],"/"))[1])
        }
      }  
    }
    presAlt <- (29.92-presVec)*1000+apAlt
    denAlt <- presAlt+118.8*(tempVec-13.39)
    ifelse(elevation=="m",apAlt<-apAlt/3.281,"")
    ifelse(elevation=="m",denAlt<-denAlt/3.281,"")
    cat("\n")
    cat("City =",airportDF$City,":",airportDF$Country,"\n")
    cat("Airport Altitude =",round(apAlt,0),elevation,"\n")
    cat("Density Altitude =",round(denAlt,0),elevation,"\n")
    options(warn = defaultW)
  }
}
