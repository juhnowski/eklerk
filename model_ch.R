library(readxl)
ch_data <- read_excel("chernorechie_vozd_do_5_iyulya_2022.xlsx", col_types = c("skip", "date", "numeric", "numeric"))

library(sparklyr)
sc <- spark_connect(master = "local", version = "3.3.0", hadoop_version = "3")
ch_data_tbl <- copy_to(sc, ch_data, overwrite = TRUE)

# разделяем данные на "обучающие" и "тестовые"
partitions <- ch_data_tbl %>%
    select(T_C, RH_) %>%
    sdf_random_split(training = 0.5, test = 0.5, seed = 1099)

# подгоняем линейную модель к набору обучающих данных
fit <- partitions$training %>%
    ml_linear_regression(T_C ~ .)

fit

summary(fit)

# используем модель
pred <- ml_predict(fit, partitions$test)

res <- head(pred)

library(dplyr)

pred %>% as_tibble %>% print(n=40)