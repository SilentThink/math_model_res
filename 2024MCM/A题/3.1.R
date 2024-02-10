# 创建修改后的数据
set.seed(123)
sex_ratio <- seq(0, 1, by = 0.05)
population1 <- 100 + 50 * sex_ratio - 100 * sex_ratio^2 + rnorm(length(sex_ratio), mean = 0, sd = 10)
population2 <- 80 + 120 * sex_ratio - 150 * sex_ratio^2 + rnorm(length(sex_ratio), mean = 0, sd = 15)
population3 <- 150 - 100 * sex_ratio + 50 * sex_ratio^2 + rnorm(length(sex_ratio), mean = 0, sd = 10)
population4 <- 70 + 90 * sex_ratio - 80 * sex_ratio^2 + rnorm(length(sex_ratio), mean = 0, sd = 12)

# 将数据合并为一个数据框
data <- data.frame(Sex_Ratio = sex_ratio, Population1 = population1, Population2 = population2, Population3 = population3, Population4 = population4)

# 创建散点图和曲线拟合
plot <- ggplot(data, aes(x = Sex_Ratio)) +
  geom_point(aes(y = Population1, color = "parasite"), size = 3) +
  geom_point(aes(y = Population2, color = "waterfowl"), size = 3) +
  geom_point(aes(y = Population3, color = "prey"), size = 3) +
  geom_point(aes(y = Population4, color = "competitor"), size = 3) +
  geom_smooth(aes(y = Population1), method = "lm", formula = y ~ poly(x, 2), color = "blue", se = FALSE) +
  geom_smooth(aes(y = Population2), method = "lm", formula = y ~ poly(x, 2), color = "red", se = FALSE) +
  geom_smooth(aes(y = Population3), method = "lm", formula = y ~ poly(x, 2), color = "green", se = FALSE) +
  geom_smooth(aes(y = Population4), method = "lm", formula = y ~ poly(x, 2), color = "purple", se = FALSE) +
  labs(x = "male sex ratio", y = "population") +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.1)) +
  scale_color_manual(values = c("parasite" = "blue", "waterfowl" = "red", "prey" = "green", "competitor" = "purple")) +
  theme_minimal() +
  theme(legend.title = element_blank())

# 打印图形
print(plot)
