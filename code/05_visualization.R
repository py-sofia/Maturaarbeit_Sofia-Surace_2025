
############################### weights histogram ############################## 

# Create data frame
df <- data.frame(
  weight = c(E(netTest)$weight, E(netControl)$weight),
  group = c(rep("netTest", ecount(netTest)),
            rep("netControl", ecount(netControl)))
)

# Plot
ggplot(df, aes(x = weight, fill = group)) +
  geom_histogram(position = "dodge", bins = 100, color = "white") +
  coord_cartesian(xlim = c(0, 0.25)) + 
  theme_minimal() +
  labs(title = "Edge Weight Distribution",
       x = "Edge Weight",
       y = "Count") +
  scale_fill_manual(values = c("skyblue", "tomato"))



################################ network graphs ################################ 

componentsInfoTest <- components(netTest)
giantTest <- induced_subgraph(netTest, 
                              which(componentsInfoTest$membership == which.max(componentsInfoTest$csize)))

comTest <- cluster_louvain(giantTest)
V(giantTest)$color <- brewer.pal(n = length(comTest), name = "Set3")[comTest$membership]

edgeColorFnTest <- col_numeric(palette = c("#fff", "#404040"), domain = NULL)
E(giantTest)$color <- edgeColorFnTest(E(giantTest)$weight)

pdf("netTest.pdf", width = 12, height = 12)
plot(giantTest,
     layout = layout_with_drl(giantTest),
     vertex.label = NA,
     vertex.size = 1,
     vertex.frame.color = NA,
     edge.arrow.mode = 0)
dev.off()


componentsInfoControl <- components(netControl)
giantControl <- induced_subgraph(netControl, 
                                 which(componentsInfoControl$membership == which.max(componentsInfoControl$csize)))

comControl <- cluster_louvain(giantControl)
V(giantControl)$color <- brewer.pal(n = length(comControl), name = "Set3")[comControl$membership]

edgeColorFnControl <- col_numeric(palette = c("#fff", "#404040"), domain = NULL)
E(giantControl)$color <- edgeColorFnControl(E(giantControl)$weight)

pdf("netControl.pdf", width = 12, height = 12)
plot(giantControl,
     layout = layout_with_drl(giantControl),
     vertex.label = NA,
     vertex.size = 1,
     vertex.frame.color = NA,
     edge.arrow.mode = 0)
dev.off()


################################### node degrees ###############################

# Degree vectors
degTest <- degree(netTest, mode = "all")
degControl <- degree(netControl, mode = "all")


# Combine into dataframe
df_deg <- data.frame(
  degree = c(degTest, degControl),
  group = c(rep("netTest", length(degTest)),
            rep("netControl", length(degControl)))
)

# Compute mean degrees
mean_df <- df_deg %>%
  group_by(group) %>%
  summarise(mean = mean(degree), .groups = "drop")

# Plot
ggplot(df_deg, aes(x = degree, fill = group)) +
  geom_histogram(
    binwidth = 1,
    color = "white",
    position = position_dodge(preserve = "single", width = 0.9)
  ) +
  coord_cartesian(xlim = c(0, 50)) +  # adjust as needed
  theme_minimal() +
  labs(
    title = "Node Degree Distribution (Side by Side)",
    x = "Degree",
    y = "Count"
  ) +
  scale_fill_manual(values = c("skyblue", "tomato")) +
  scale_color_manual(values = c("skyblue", "tomato"))



