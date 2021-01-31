suppressPackageStartupMessages(library("dplyr"))
d <- read.table(here::here(file.path("data", "dataPkg.csv2")),
  sep=";", header=TRUE, quote="")
keywords <- d$Keywords[d$Keywords != ""]
keywords <- unique(sort(unlist(strsplit(keywords, ",", fixed=TRUE))))
write(keywords, "keywords.txt")
