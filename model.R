library(sparklyr)
sc <- spark_connect(master = "local", version = "3.3.0", hadoop_version = "3")
mtcars_tbl <- copy_to(sc, mtcars, overwrite = TRUE)

# разделяем данные на "обучающие" и "тестовые"
partitions <- mtcars_tbl %>%
    select(mpg, wt, cyl) %>%
    sdf_random_split(training = 0.5, test = 0.5, seed = 1099)

# подгоняем линейную модель к набору обучающих данных
fit <- partitions$training %>%
    ml_linear_regression(mpg ~ .)

fit

summary(fit)

# используем модель
pred <- ml_predict(fit, partitions$test)

head(pred)
