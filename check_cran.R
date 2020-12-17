CRAN_db <- tools::CRAN_package_db()
CRAN_package <- CRAN_db[, "Package"]
CRAN_title <- CRAN_db[,  "Title"]
d <- read.table(here::here("dataPkg.csv2"), sep=";", header=TRUE, quote="")
match_on_cran <- match(d[, "Package"], CRAN_package, nomatch=-1)
indx_not_on_cran <- which(match_on_cran < 0)
not_on_cran <- d[indx_not_on_cran, ]
write.table(not_on_cran, "archived_dataPkgs.csv2", sep=";", row.names=FALSE,
  quote=FALSE)
dnew <- d[-indx_not_on_cran,]
write.table(dnew, "dataPkg.csv2", sep=";", row.names=FALSE,
  quote=FALSE)
