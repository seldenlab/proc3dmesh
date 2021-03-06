#batch convert STL to PLY (ASCII)
#all NextEngine meshes preprocessed in ScanStudio (trim, align, merge, polish, remesh)
#all SkyScan meshes preprocessed in SlicerMorph (segmentation)
require(devtools)
install_github("zarquon42b/Rvcg", local=FALSE)
library(Rvcg)
library(rgl)
# set working directory
setwd(getwd())
###################

processmesh <- function(x) {
    mesh<-vcgImport(x, updateNormals = TRUE, readcolor = FALSE, clean = TRUE, silent = FALSE)
    meshname <- gsub(".stl","",basename(x))
    #export as PLY to ply folder
    vcgPlyWrite(mesh, filename = paste0("ply/",meshname))
}

# Batch loop assuming all stl files are stored in a folder called stl
mystls <- list.files("stl",pattern=".stl",full.names=T)
runall <- lapply(mystls,processmesh)
# end of script