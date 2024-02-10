# 创建自定义数据
custom_data <- data.frame(
  Sex_Ratio = c( 0.1 , 0.15, 0.2 , 0.25, 0.3 , 0.35, 0.4 , 0.45,0.5,0.55,0.6,0.7,0.75,0.8,0.85,0.9,0.95),
  Score =     c( 27  , 30  , 32  , 37  , 42  , 50  , 57  , 62  ,68, 74 , 77, 80, 76, 73 , 67 , 60, 53)
)

# 创建散点图和拟合曲线
plot <- ggplot(custom_data, aes(x = Sex_Ratio, y = Score)) +
  geom_point(size = 3, alpha = 0.7) +  # 减小点的大小和增加透明度
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), color = "blue", se = FALSE) +
  labs(x = "Male Sex Ratio", y = "Score") +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.1)) +
  scale_y_continuous(limits = c(0, 100)) +  # 设置纵坐标范围
  theme_minimal() +
  theme(legend.position = "none")  # 去掉图例

# 打印图形
print(plot)
