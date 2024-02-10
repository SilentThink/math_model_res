library(corrplot)

# 相关系数矩阵
cor_matrix <- matrix(c(
  1.000, 0.925, 0.787, 0.720, 0.449,
  0.925, 1.000, 0.839, 0.653, 0.446,
  0.787, 0.839, 1.000, 0.559, 0.367,
  0.720, 0.653, 0.559, 1.000, 0.648,
  0.449, 0.446, 0.367, 0.648, 1.000
), byrow = TRUE, nrow = 5)

# 设置列名和行名
rownames(cor_matrix) <- colnames(cor_matrix) <- c("Y", "X1", "X2", "X3", "X4")

# 自定义颜色
my_colors <- colorRampPalette(c("#76B947", "#FFFFFF", "#A349A4"))(200) # 绿-白-紫


# 绘制完整的相关矩阵
corrplot(cor_matrix, method = "color",col = my_colors, type = "full", order = "original", 
         tl.col = "black", tl.srt = 45, addCoef.col = "black", 
         number.cex = 0.7, diag = TRUE)

# 添加额外的美化元素
corrplot(cor_matrix, method = "circle",,col = my_colors , type = "full", order = "original", 
         tl.col = "black", tl.srt = 45, addCoef.col = "black", 
         number.cex = 0.7, diag = FALSE, add = FALSE)

