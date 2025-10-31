
log_data <- log2(expression_matrix +1)  # +1 to avoid log(0) (term: pseudocount)
norm_data <- normalize.quantiles(log_data)



# Create density plot
png(file="results/normalization/not_normalized.png",width=700,height=600)
plot(density(expression_matrix[,1], na.rm=TRUE), 
     col=1, lwd=2,
     main="Expression Distribution Across Samples",
     xlab="Expression", ylab="Density",
     xlim=range(expression_matrix, na.rm=TRUE))
dev.off()

png(file="results/normalization/log2_normalized.png",width=700,height=600)
plot(density(log_data[,1], na.rm=TRUE), 
     col=1, lwd=2,
     main="log2(Expression) Distribution Across Samples",
     xlab="log2(Expression)", ylab="Density",
     xlim=range(log_data, na.rm=TRUE))
dev.off()



png(file="results/normalization/not_normalized_qq.png",width=700,height=600)
qqnorm(expression_matrix[,1])
dev.off()

png(file="results/normalization/log2_quantile_normalized_qq.png",width=700,height=600)
plot(expression_matrix[,1], norm_data[,1])
qqnorm(norm_data[,1])
dev.off()


