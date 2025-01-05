# plumber

It is labelled as `an API generator in R`, which has tested through Caprion data as follows.

```r
library(plumber)
library(seqminer)
library(jsonlite)

get_data <- function(filename, region)
{
  if (!file.exists(filename)) {
    stop(paste("File", filename, "not found"))
  }
  query_result <- seqminer::tabix.read(filename, region)
  hdr <- c("Chromosome", "Position", "MarkerName", "Allele1", "Allele2", "Freq1", "FreqSE", "MinFreq", 
           "MaxFreq", "Effect", "StdErr", "logP", "Direction", "HetISq", "HetChiSq", "HetDf", "logHetP", "N")
  df <- read.table(text = paste(query_result, collapse = "\n"), sep = "\t", col.names=hdr)
  return(df)
}

options(width = 200)
filename <- file.path("METAL_dr","ZPI_dr-1.tbl.gz")
region <- "1:10000-20000"
data <- get_data(filename, region)
head(data,1)

plbr <- plumber::Plumber$new()
plbr$handle("GET", "/data", function(req, res) {
  filename <- req$args$filename
  region <- req$args$region
  if (is.null(filename) || is.null(region)) {
    res$status <- 400
    return(list(error = "Both 'filename' and 'region' must be provided"))
  }
  filename <- file.path("METAL_dr",filename)
  print(filename)
  if (!file.exists(filename)) {
    res$status <- 404
    return(list(error = paste("File", filename, "not found")))
  }
  data <- get_data(filename, region)
  json_data <- toJSON(data, dataframe = "rows")
  res$setHeader("Content-Type", "application/json")
  return(json_data)
})
plbr$run(port = 8001)
```

We see that,

```
> head(data,1)
  Chromosome Position   MarkerName Allele1 Allele2  Freq1 FreqSE MinFreq MaxFreq      Effect    StdErr  logP Direction HetISq HetChiSq HetDf logHetP    N
1          1    10352 1:10352_T_TA       t      ta 0.6147 0.0038  0.6122  0.6273 -0.05283738 0.0335632 -0.94    +--???    5.2    2.109     2 -0.4579 2491
```

and

```
Running plumber API at http://127.0.0.1:8001
Running swagger Docs at http://127.0.0.1:8001/__docs__/
```

So we get query results in JSON format from

- browser: http://localhost:8001/data?filename=ZPI_dr-1.tbl.gz&region=1:10000-20000
- curl: curl "http://localhost:8001/data?filename=ZPI_dr-1.tbl.gz&region=1:10000-20000"
