library(readr)
MainDataFrame <- read_delim("data/MainDataFrame.csv",
                            ";", escape_double = FALSE, col_types = cols(today = col_date(format = "%Y-%m-%d")),
                            trim_ws = TRUE)

write.csv(MainDataFrame, "data/MainDataFrame_raw.csv", row.names = FALSE)

MainDataFrame <- read.csv("data/MainDataFrame_raw.csv")

ctry <- as.data.frame(levels(as.factor(MainDataFrame$monit.progres_CountryofAsylum)))
names(ctry) <- "country"

table(MainDataFrame$monit.progres_CountryofAsylum)

ctry <- as.data.frame(ctry[ ctry$country %in% c("Argentina",
                                 # "Aruba",
                                #  "Belize",
                                  "Chile",
                                  "Ecuador",
                                 # "Guatemala",
                                #  "notsaid",
                                 # "Panama",
                                  "Peru",
                                  "RepublicaDominicana"), ])
names(ctry) <- "country"
names(MainDataFrame)

MainDataFrame <- MainDataFrame[MainDataFrame$monit.progres_CountryofAsylum %in% as.character(ctry$country),  ]

table(round( (MainDataFrame$end_mins4 - MainDataFrame$start_mins) , 0))

write.csv(MainDataFrame, "data/MainDataFrame_raw2.csv", row.names = FALSE)


library(koboloadeR)
form <- "form.xls"

### Render now all reports
cat(" Render now reports... \n")
for (i in 1:nrow(ctry)) {

  # i <- 1
  ctryfilter <- as.character(ctry[ i , 1])
  MainDataFrame <- read.csv("data/MainDataFrame_raw2.csv")
  MainDataFrame$monit.progres_CountryofAsylum <- as.character(MainDataFrame$monit.progres_CountryofAsylum)
  MainDataFrame <- MainDataFrame[MainDataFrame$monit.progres_CountryofAsylum == ctry,  ]
  write.csv(MainDataFrame, "data/MainDataFrame.csv", row.names = FALSE)


  kobo_load_data(form)
  kobo_crunching_report(form, output = "aspx")
  kobo_crunching_report(form, output = "docx")
  kobo_crunching_report(form, output = "pptx")

  mainDir <- kobo_getMainDirectory()
  file.rename(paste(mainDir,"/out/crunching_reports/Crunching-report-1-Crunch-",Sys.Date(), "-report.aspx", sep = ""),
              paste0(mainDir,"/out/crunching_reports/Crunching-report-",ctryfilter,"-", Sys.Date(), ".aspx")  )

  file.rename(paste(mainDir,"/out/crunching_reports/Crunching-report-1-Crunch-",Sys.Date(), "-report.docx", sep = ""),
              paste0(mainDir,"/out/crunching_reports/Crunching-report-",ctryfilter,"-", Sys.Date(), ".docx")  )

  file.rename(paste(mainDir,"/out/crunching_reports/Crunching-report-1-Crunch-",Sys.Date(), "-report.pptx", sep = ""),
              paste0(mainDir,"/out/crunching_reports/Crunching-report-",ctryfilter,"-", Sys.Date(), ".pptx")  )


}

