
# number of nodes
vcount(netTest)
vcount(netControl)

# number of edges
gsize(netTest)
gsize(netControl)


# proportion of present edges from all possible edges in the network
edge_density(netTest, loops=F)
edge_density(netControl, loops=F)


# longest length of the shortest path between two nodes
diameter(netTest, directed=F) # ~2min to compute -> 2.04
diameter(netControl, directed=F) #               -> 1.73



