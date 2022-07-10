install.packages("tidyverse")
tidyverse_update()
install.packages(c("broom", "dbplyr", "rlang", "sparklyr"))

library(tidyverse)

install.packages(c("nycflights13", "gapminder", "Lahman"))

library(sparklyr)
sc <- spark_connect(master = "local", version = "3.3.0", hadoop_version = "3")
flights_tbl <- copy_to(sc, nycflights13::flights, "spark_flights")

delay <- flights_tbl %>%
 group_by(tailnum) %>%
 summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
 ) %>%
 filter(count > 20, dist < 2000, !is.na(delay))