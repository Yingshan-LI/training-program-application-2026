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


# Load libraries ------------------------

library(tidyverse)


# Importing gene expression matrix and sample metadata from the data directory
expression_data <- read_csv("data/GSE60450_GeneLevel_Normalized(CPM.and.TMM)_data.csv")
metadata <- read_csv("data/GSE60450_filtered_metadata.csv")


# Inspect the data ------------------------

## Expression data
dim(expression_data)
head(expression_data)

## Metadata
dim(metadata)
head(metadata)


# Prepare/combine the data for plotting ------------------------

## Pivoting from wide format to long format
## Excluding non-expression columns (...1, gene_symbol) to create a single 'expression' column
exp_long <- expression_data %>%
  pivot_longer(cols = -c(...1, gene_symbol), 
               names_to = "sample_id", 
               values_to = "expression")

## Joining expression values with metadata using sample IDs
combined_data <- inner_join(exp_long, metadata, by = c("sample_id" = "...1"))

## Verify the merged structure
head(combined_data)

# Plot the data --------------------------
## Plot the expression by cell type (immunophenotype)
plot <- ggplot(combined_data, aes(x = immunophenotype, y = expression, fill = immunophenotype)) +
  geom_boxplot() +
  scale_y_log10() + 
  theme_minimal() +
  labs(title = "RNA-seq Expression by Immunophenotype",
       subtitle = "Data: GSE60450",
       x = "Immunophenotype",
       y = "Expression (Log10)") +    # Apply a log10 transformation to the Y-axis. 
  theme(legend.position = "none", 
        axis.text.x = element_text(hjust = 1))


print(plot)

## Save the plot
ggsave("results/expression_boxplot.png", plot = plot, width = 4, height = 6)




