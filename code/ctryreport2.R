
library(koboloadeR)

form <- paste0("form.xls")
kobo_load_data(form)
kobo_crunching_report(form, output = "aspx")
kobo_crunching_report(form, output = "docx")
kobo_crunching_report(form, output = "pptx")

ctry <- as.data.frame( c("Argentina", "Chile","Ecuador", "Peru", "Guatemala",  "RepublicaDominicana"))

ctry <- as.data.frame( c( "Guatemala"))
## english
for (i in 1:nrow(ctry)) {
  # i <- 1
  ctryfilter <- as.character(ctry[ i , 1])
  form <- paste0("formctry",ctryfilter,".xls")
  kobo_load_data(form)
  kobo_crunching_report(form, output = "aspx")
  mainDir <- kobo_getMainDirectory()
  file.rename(paste(mainDir,"/out/crunching_reports/Crunching-report-1-Crunch-",Sys.Date(), "-report.aspx", sep = ""),
              paste0(mainDir,"/out/crunching_reports/Crunching-report-",ctryfilter, ".aspx")  )
  #  paste0("C:/Users/LEGOUPIL/UNHCR/Americas Protection Monitoring - analysis/Crunching-report-",ctryfilter,"-", Sys.Date(), ".aspx")  )
  
  kobo_crunching_report(form, output = "docx")
  mainDir <- kobo_getMainDirectory()
  file.rename(paste(mainDir,"/out/crunching_reports/Crunching-report-1-Crunch-",Sys.Date(), "-report.docx", sep = ""),
              paste0(mainDir,"/out/crunching_reports/Crunching-report-",ctryfilter, ".docx")  )

  kobo_crunching_report(form, output = "pptx")
  mainDir <- kobo_getMainDirectory()
  file.rename(paste(mainDir,"/out/crunching_reports/Crunching-report-1-Crunch-",Sys.Date(), "-report.pptx", sep = ""),
              paste0(mainDir,"/out/crunching_reports/Crunching-report-",ctryfilter, ".pptx")  )
}


## Spanish

## For aspx nedd to add manually - <meta http-equiv="Content-type" content="text/html; charset=utf-8" /> 
for (i in 1:nrow(ctry)) {
  # i <- 1
  ctryfilter <- as.character(ctry[ i , 1])
  form <- paste0("formctry",ctryfilter,"-ESP.xls")
  kobo_load_data(form)
  kobo_crunching_report(form, output = "aspx", lang = "esp")
  mainDir <- kobo_getMainDirectory()
  file.rename(paste(mainDir,"/out/crunching_reports/Crunching-report-1-Crujido-",Sys.Date(), "-report.aspx", sep = ""),
              paste0(mainDir,"/out/crunching_reports/Crujido-report-",ctryfilter, ".aspx")  )
  
  # zz <- file(paste0(mainDir,"/out/crunching_reports/Crujido-report-",ctryfilter, ".aspx") ,"w")
  # writeLines("<meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\" />", con=zz, sep="\n")
  # close(zz)
  
  
  #  paste0("C:/Users/LEGOUPIL/UNHCR/Americas Protection Monitoring - analysis/Crunching-report-",ctryfilter,"-", Sys.Date(), ".aspx")  )

   kobo_crunching_report(form, output = "docx", lang = "esp")
   mainDir <- kobo_getMainDirectory()
   file.rename(paste(mainDir,"/out/crunching_reports/Crunching-report-1-Crujido-",Sys.Date(), "-report.docx", sep = ""),
               paste0(mainDir,"/out/crunching_reports/Crujido-report-",ctryfilter, ".docx")  )

   kobo_crunching_report(form, output = "pptx", lang = "esp")
   mainDir <- kobo_getMainDirectory()
   file.rename(paste(mainDir,"/out/crunching_reports/Crunching-report-1-Crujido-",Sys.Date(), "-report.pptx", sep = ""),
               paste0(mainDir,"/out/crunching_reports/Crujido-report-",ctryfilter, ".pptx")  )
}

