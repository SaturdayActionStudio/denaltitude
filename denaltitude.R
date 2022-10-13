## Only a function script right now. Still testing the parsing of a METAR. Eventually will be a package.
## There are potential issues with identifying and parsing temperature and pressure values from the METAR.
## Provide denaltitude with valid ICAO airport code in quotes. Elevation units can be "ft" for feet (default) or "m" for meters.
## Example: denaltitude("KFWA",elevation="ft")
##
denaltitude=function(airportCode,elevation="ft"){
  airportDF=as.data.frame(airportr::airport_detail(airportCode))
  apAlt=airportDF$Altitude
  reMetar=pmetar::metar_get(airportCode)
  if (reMetar[1]=="No METAR found!") {reMetar[1]} else {
    reMetar=unlist(str_split(reMetar," "))
    for (j in 1:length(reMetar)) {
      ifelse(substr(reMetar[j],1,1)=="A",ifelse(nchar(reMetar[j])==5,presLoc<-j,""),"")
    }
    presVec=unlist(str_split(reMetar[presLoc],"A"))
    presHg=strtoi(presVec[2])/100
    for (i in 1:length(reMetar)) {
      ifelse(grepl("/",reMetar[i])==TRUE,ifelse(nchar(reMetar[i])<=7,tempLoc<-i,""),"")
    }
    tempVec=unlist(str_split(reMetar[tempLoc],"/"))
    tempC=strtoi(tempVec[1])
    presAlt=(29.92-presHg)*1000+apAlt
    denAlt=presAlt+118.8*(tempC-13.39)
    ifelse(elevation=="m",apAlt<-apAlt/3.281,"")
    ifelse(elevation=="m",denAlt<-denAlt/3.281,"")
    cat("City =",airportDF$City,":",airportDF$Country,"\n")
    cat("Airport Altitude =",round(apAlt,0),elevation,"\n")
    cat("Density Altitude =",round(denAlt,0),elevation)
  }
}
