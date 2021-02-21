library(quantmod)
library(lubridate)

# Get Google stock
dt <- getSymbols("GOOGL", from = "2019-02-12", to = ymd(Sys.Date()))
stock <- GOOGL
colnames(stock) <- gsub("GOOGL.", "", colnames(stock))

# I like to set min higher a little bit
min <- min(stock$Close) - (max(stock$Close) / 5)
max <- max(stock$Close)

# Change length.out to see different
gradient_df <- data.frame(yintercept = seq(0, max(stock$Close), length.out = 600),
                          alpha = seq(1,0,length.out = 600))


p <- ggplot(stock, aes(x = index(stock), y = Close)) +
  geom_area(fill = "#32907c", alpha = 1) +
  geom_hline(data = gradient_df,
             aes(yintercept = yintercept, alpha = alpha),
             size = 1,
             colour = "white") +
  geom_line(colour = "#32907c", size = 1) +
  coord_cartesian(ylim = c(min, max))
p <- p + labs(title = paste0("GOOGL"," 2019-02-12"," : ",Sys.Date()) ,x = "Date", y = "Price ($)")
p <- p + theme(legend.position = "none")
p
