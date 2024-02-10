# 创建修改后的数据
set.seed(123)
sex_ratio <- seq(0, 1, length.out = 21)  # 使用21个点
score <- 100 - 500 * (sex_ratio - 0.5)^2 + rnorm(length(sex_ratio), mean = 0, sd = 5)  # 开口向下的二次函数，调整系数以获得更好的拟合效果

# 将数据合并为一个数据框
data <- data.frame(Sex_Ratio = sex_ratio, Score = score)

# 创建散点图和曲线拟合
plot <- ggplot(data, aes(x = Sex_Ratio, y = Score)) +
  geom_point(size = 3, alpha = 0.7) +  # 减小点的大小和增加透明度
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), color = "blue", se = FALSE) +
  labs(x = "Male Sex Ratio", y = "Score") +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.1)) +
  scale_y_continuous(limits = c(0, 100)) +  # 设置纵坐标范围
  theme_minimal() +
  theme(legend.position = "none")  # 去掉图例

# 打印图形
print(plot)
