library(sparklyr)
library(dplyr)
spark_install(version = "3.3.0", hadoop_version = "3")
sc <- spark_connect(master = "local", version = "3.3.0", hadoop_version = "3")
library(readxl)
ch_data <- read_excel("chernorechie_vozd_do_5_iyulya_2022.xlsx", col_types = c("skip", "date", "numeric", "numeric")) # nolint
View(ch_data)
tbl_ch_data <- copy_to(sc, ch_data, "chernorechie_vozd_do_5_iyulya_2022_1")
