suppressPackageStartupMessages(library("dplyr"))
FILE <- "du_SRC_20210129.txt"
d <- read.table(here::here(file.path("data", FILE)), sep="\t",
  col.names=c("size", "path"))
d[["package"]] <- vapply(d$path, function(x) strsplit(x, "/")[[1]][2], "")
upackage <- unique(d[["package"]])
package_data <- paste0("./", upackage, "/data")
indx_data <- match(package_data, d$path, nomatch=-1)
if(any(indx_data < 0)) {
  indx_data <- indx_data[indx_data > 0]
}
d_data <- d[indx_data, ] %>% rename(data_size = size) %>% select(-path)
package_R <- paste0("./", upackage, "/R")
indx_R <- match(package_R, d$path, nomatch=-1)
if(any(indx_R < 0)) {
  indx_R <- indx_R[indx_R > 0]
}
d_R <- d[indx_R, ] %>% rename(R_size = size) %>% select(-path)
package_src <- paste0("./", upackage, "/src")
indx_src <- match(package_src, d$path, nomatch=-1)
if(any(indx_src < 0)) {
  indx_src <- indx_src[indx_src > 0]
}
d_src <- d[indx_src, ] %>% rename(src_size = size) %>% select(-path)
d_dataR <- d_data %>% left_join(d_R, by="package") %>%
  mutate(data_to_R = data_size / R_size) %>%
  select(package, data_to_R, data_size, R_size) 
d_dataRsrc <- d_data %>% left_join(d_R, by="package") %>%
  mutate(data_to_R = data_size / R_size) %>%
  left_join(d_src, by="package") %>%
  select(package, data_to_R, data_size, R_size, src_size) 
