  library(ggplot2)
library(directlabels)

# Create some custom lineplot-label positioning functions:
line.startpoint <- function(d, ...) {
  transform(gapply(d, subset, x == min(x)), hjust = 1)
}
line.endpoint <- function(d, ...) {
  transform(gapply(d, subset, x == max(x)), hjust = 0)
} 
line.extremepoints <- dl.combine(line.startpoint, line.endpoint)

# Take data from the medium test:
alpha.data <- data.frame(size = c(1, 2, 3, 4, 5), power = c(1, 1.25, 1.75, 2.5, 3.5), category = "Alpha")
beta.data <- data.frame(size = c(1, 2, 3, 4, 5), power = c(1.5, 3, 5, 7.25, 9.5), category = "Beta")
gamma.data <- data.frame(size = c(1, 2, 3, 4, 5), power = c(2, 4, 6.5, 10, 13.5), category = "Gamma")
df <- rbind(alpha.data, beta.data, gamma.data)

# Create the ggplot object to plot the data, compare the defined positioning methods via dlcompare on that, and finally save the returned result as a .png file via ggsave to be later accessible to the runner: 
g <- ggplot(df, aes(size, power, color = category)) + geom_line() + xlim(0, 6) + labs(x = "Particle Size", y = "Penetration Power") + coord_cartesian(clip = "off")
ggsave("result.png", dlcompare(list(lineplot.methods = g), list("line.startpoint", "line.endpoint", "line.extremepoints")), device = "png")
