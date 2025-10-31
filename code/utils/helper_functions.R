# source: https://static-content.springer.com/esm/art%3A10.1186%2F1471-2105-11-497/MediaObjects/12859_2010_4080_MOESM1_ESM.DOC

# uses module assignment list as input
# writes individual files witht he probeset ids for each module
extractModules <- 
  function(colorh1, datExpr, anno, write=F, file_prefix="", dir=NULL)
  {
    module <- list()
    if (!is.null(dir))
    {
      dir.create(dir)
      file_prefix=paste(dir, "/", file_prefix, sep="")
    }
    i <- 1
    for (c in unique(colorh1))
    {
      module[[i]] <- (anno[colnames(datExpr)[which(colorh1 == c)], 1])
      if (write)
      { 
        write.table(rownames(anno)[which(colorh1 == c)], 
                    file=paste(file_prefix, "_", c, ".txt", sep=""), 
                    quote=F, row.names=F, col.names=F)
      }
      i <- i+1
    }
    names(module) <- unique(colorh1)
    module
  }
