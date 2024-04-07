#get data
data <- read.table("G_all.results", header = TRUE, fill=TRUE)

#fix formatting issues
num_rows <- nrow(data)
data <- data[1:(num_rows - 4), ]
data$file_name <- sub("\\.results$", "", data$file_name)

#keep only the enrichment, se, and p-value columms
keep_columns <- c('file_name', 'Enrichment', 'Enrichment_std_error', 'Enrichment_p')
filtered_data <- subset(data, select = keep_columns)

#perform FDR correction using the Benjamini-Hochberg (BH) method
adjusted_p_values_bh <- p.adjust(filtered_data$Enrichment_p, method = "BH")

filtered_data$padj_bh <- adjusted_p_values_bh

