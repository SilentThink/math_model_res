import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

# 创建x和y的坐标数组
x = np.arange(0.05, 1, 0.05)
y = np.arange(0.05, 1, 0.05)
x, y = np.meshgrid(x, y)

# 定义z值的函数
def z_func(x, y):
    # 在x=0.7附近z值较高，同时z值随着y的增加而增加
    # 使用一个因子来调整z的范围到800至5000
    z = np.exp(-(x - 0.7)**2) + y
    z = z / z.max()  # 正规化到0-1
    z = 800 + z * 4200  # 缩放到800-5000
    return z

# 计算z坐标
z = z_func(x, y)

# 添加噪声
noise_strength = 0.03 * 4200  # 噪声强度调整为z值范围的百分比
z += noise_strength * np.random.normal(size=z.shape)

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# 绘制曲面
surf = ax.plot_surface(x, y, z, cmap='viridis', edgecolor='none')

# 添加颜色条
fig.colorbar(surf)

# 设置轴标签
ax.set_xlabel('male probability')
ax.set_ylabel('birth probability')
ax.set_zlabel('parasitized population')


plt.show()
