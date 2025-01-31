% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getUMAP.R
\name{getUMAP}
\alias{getUMAP}
\title{Run UMAP embedding with scater method}
\usage{
getUMAP(
  inSCE,
  useAssay = "logcounts",
  useReducedDim = NULL,
  useAltExp = NULL,
  sample = NULL,
  reducedDimName = "UMAP",
  logNorm = FALSE,
  useFeatureSubset = NULL,
  nTop = 2000,
  scale = TRUE,
  pca = TRUE,
  initialDims = 25,
  nNeighbors = 30,
  nIterations = 200,
  alpha = 1,
  minDist = 0.01,
  spread = 1,
  seed = NULL,
  BPPARAM = BiocParallel::SerialParam()
)
}
\arguments{
\item{inSCE}{Input \linkS4class{SingleCellExperiment} object.}

\item{useAssay}{Assay to use for UMAP computation. If \code{useAltExp} is
specified, \code{useAssay} has to exist in
\code{assays(altExp(inSCE, useAltExp))}. Ignored when using 
\code{useReducedDim}. Default \code{"logcounts"}.}

\item{useReducedDim}{The low dimension representation to use for UMAP
computation. If \code{useAltExp} is specified, \code{useReducedDim} has to 
exist in \code{reducedDims(altExp(inSCE, useAltExp))}. Default \code{NULL}.}

\item{useAltExp}{The subset to use for UMAP computation, usually for the
selected variable features. Default \code{NULL}.}

\item{sample}{Character vector. Indicates which sample each cell belongs to.
If given a single character, will take the annotation from \code{colData}. 
Default \code{NULL}.}

\item{reducedDimName}{A name to store the results of the UMAP embedding
coordinates obtained from this method. Default \code{"UMAP"}.}

\item{logNorm}{Whether the counts will need to be log-normalized prior to
generating the UMAP via \code{\link{scaterlogNormCounts}}. Ignored when using
\code{useReducedDim}. Default \code{FALSE}.}

\item{useFeatureSubset}{Subset of feature to use for dimension reduction. A 
character string indicating a \code{rowData} variable that stores the logical
vector of HVG selection, or a vector that can subset the rows of 
\code{inSCE}. Default \code{NULL}.}

\item{nTop}{Automatically detect this number of variable features to use for
dimension reduction. Ignored when using \code{useReducedDim} or using 
\code{useFeatureSubset}. Default \code{2000}.}

\item{scale}{Whether \code{useAssay} matrix will need to be standardized. 
Default \code{TRUE}.}

\item{pca}{Logical. Whether to perform dimension reduction with PCA before
UMAP. Ignored when using \code{useReducedDim}. Default \code{TRUE}.}

\item{initialDims}{Number of dimensions from PCA to use as input in UMAP.
Default \code{25}.}

\item{nNeighbors}{The size of local neighborhood used for manifold
approximation. Larger values result in more global views of the manifold,
while smaller values result in more local data being preserved. Default
\code{30}. See \code{\link[scater]{calculateUMAP}} for more information.}

\item{nIterations}{The number of iterations performed during layout
optimization. Default is \code{200}.}

\item{alpha}{The initial value of "learning rate" of layout optimization.
Default is \code{1}.}

\item{minDist}{The effective minimum distance between embedded points.
Smaller values will result in a more clustered/clumped embedding where nearby
points on the manifold are drawn closer together, while larger values will
result on a more even dispersal of points. Default \code{0.01}. See
\code{\link[scater]{calculateUMAP}} for more information.}

\item{spread}{The effective scale of embedded points. In combination with
\code{minDist}, this determines how clustered/clumped the embedded points 
are. Default \code{1}. See \code{\link[scater]{calculateUMAP}} for more 
information.}

\item{seed}{Random seed for reproducibility of UMAP results. 
Default \code{NULL} will use global seed in use by the R environment.}

\item{BPPARAM}{A \linkS4class{BiocParallelParam} object specifying whether 
the PCA should be parallelized.}
}
\value{
A \linkS4class{SingleCellExperiment} object with UMAP computation
updated in \code{reducedDim(inSCE, reducedDimName)}.
}
\description{
Uniform Manifold Approximation and Projection (UMAP) algorithm 
is commonly for 2D visualization of single-cell data. This function wraps the 
scater \code{\link[scater]{calculateUMAP}} function. 

With this funciton, users can create UMAP embedding directly from raw count
matrix, with necessary preprocessing including normalization, scaling, 
dimension reduction all automated. Yet we still recommend having the PCA as 
input, so that the result can match with the clustering based on the same 
input PCA.
}
\examples{
data(scExample, package = "singleCellTK")
sce <- subsetSCECols(sce, colData = "type != 'EmptyDroplet'")
# Run from raw counts
sce <- getUMAP(inSCE = sce, useAssay = "counts", logNorm = TRUE, nTop = 2000,
               scale = TRUE, pca = TRUE)
\dontrun{
# Run from PCA
sce <- scaterlogNormCounts(sce, "logcounts")
sce <- runModelGeneVar(sce)
sce <- scaterPCA(sce, useAssay = "logcounts", 
                 useFeatureSubset = "HVG_modelGeneVar2000", scale = TRUE)
sce <- getUMAP(sce, useReducedDim = "PCA")
}
}
