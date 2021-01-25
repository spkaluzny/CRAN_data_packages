CRAN_db <- tools::CRAN_package_db()
CRAN_package <- CRAN_db[, "Package"]
CRAN_title <- CRAN_db[,  "Title"]
cran_pkg_file <- here::here(file.path("data", "dataPkg.csv2"))
archived_pkg_file <- here::here(file.path("data", "archived_dataPkgs.csv2"))
d <- read.table(cran_pkg_file, sep=";", header=TRUE, quote="")
match_on_cran <- match(d[, "Package"], CRAN_package, nomatch=-1)
indx_not_on_cran <- which(match_on_cran < 0)
if(length(indx_not_on_cran) > 0) {
  not_on_cran <- d[indx_not_on_cran, ]
  write.table(not_on_cran, archived_pkg_file,
    sep=";", row.names=FALSE, quote=FALSE, append=TRUE,
    col.names=(!file.exists(archived_pkg_file)))
  dnew <- d[-indx_not_on_cran,]
  write.table(dnew, cran_pkg_file, sep=";", row.names=FALSE,
    quote=FALSE)
}
