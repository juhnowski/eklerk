library(readxl)
Черноречье_ВОЗД_до_5_июля_2022_г <- read_excel("Заповедник/Черноречье ВОЗД до 5 июля 2022 г.xlsx", col_types = c("skip", "date", "numeric", "numeric"))
View(Черноречье_ВОЗД_до_5_июля_2022_г)
t <- Черноречье_ВОЗД_до_5_июля_2022_г$`Время.Сессия 0`
T <- Черноречье_ВОЗД_до_5_июля_2022_г$`T, °C`
RH <- Черноречье_ВОЗД_до_5_июля_2022_г$`RH,   %`
plot(t, T, type = "l", col = 2) 
par(new = TRUE) 
plot(t, RH, type = "l", col = 3, axes = FALSE, xlab = "", ylab = "")
axis(side = 4, at = pretty(range(RH)))
mtext("RH", side = 4, line = 3) 