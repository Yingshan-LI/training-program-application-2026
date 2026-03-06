# ---------------------------------------------------------

# Melbourne Bioinformatics Training Program

# This exercise to assess your familiarity with R and git. Please follow
# the instructions on the README page and link to your repo in your application.
# If you do not link to your repo, your application will be automatically denied.

# Leave all code you used in this R script with comments as appropriate.
# Let us know if you have any questions!


# You can use the resources available on our training website for help:
# Intro to R: https://mbite.org/intro-to-r
# Version Control with Git: https://mbite.org/intro-to-git/

# ----------------------------------------------------------


# Load libraries -------------------

install.packages("tidyverse")
library(tidyverse)

# Load data here ----------------------

expression_data <- read_csv("data/GSE60450_GeneLevel_Normalized(CPM.and.TMM)_data.csv")
metadata <- read_csv("data/GSE60450_filtered_metadata.csv")


# Inspect the data -------------------------

# What are the dimensions of each data set? (How many rows/columns in each?)

## Expression data
dim(expression_data)
head(expression_data)

## Metadata
dim(metadata)
head(metadata)

# Prepare/combine the data for plotting ------------------------

# 转换长格式：排除前两列，把其余的样本 ID 转到 sample_id 列
exp_long <- expression_data %>%
  pivot_longer(cols = -c(...1, gene_symbol), 
               names_to = "sample_id", 
               values_to = "expression")

# 合并数据，metadata 第一列叫 ...1，与表达矩阵的样本 ID 匹配
combined_data <- inner_join(exp_long, metadata, by = c("sample_id" = "...1"))

# 验证合并结果
head(combined_data)

# Plot the data --------------------------
## Plot the expression by cell type
# 绘图：使用 immunophenotype 作为横坐标
plot <- ggplot(combined_data, aes(x = immunophenotype, y = expression, fill = immunophenotype)) +
  geom_boxplot() +
  scale_y_log10() + 
  theme_minimal() +
  labs(title = "RNA-seq Expression by Immunophenotype",
       subtitle = "Data: GSE60450",
       x = "Immunophenotype",
       y = "Expression (Log10)") +
  theme(legend.position = "none", 
        axis.text.x = element_text(angle = 45, hjust = 1)) # 让文字倾斜防止重叠


print(plot)

## Save the plot
### 保存到任务指定的 results/ 目录
#ggsave("results/expression_boxplot.png", plot = plot, width = 4, height = 6)


# Plot the data --------------------------
## Plot the expression by cell type
## Can use boxplot() or geom_boxplot() in ggplot2



## Save the plot
### Show code for saving the plot with ggsave() or a similar function
