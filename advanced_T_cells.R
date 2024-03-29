PBMC_T <- readRDS('F://scRNAseq_PBMC/Azimuth_combined_T_only.rds')
DimPlot(PBMC_T)
head(PBMC_T)
DefaultAssay(PBMC_T)
View(PBMC_T)
ProcessInt <- function(data.integrated){
data.integrated <- ScaleData(data.integrated, verbose = T, vars.to.regress = c('nCount_RNA', 'nFeature_RNA', 'percent.mt',"percent.rb","S.Score","G2M.Score"))
data.integrated <- RunPCA(data.integrated, npcs = 200, verbose = T)
data.integrated <- FindNeighbors(data.integrated, dims = 1:200)
data.integrated <- FindClusters(data.integrated, resolution = 1)
data.integrated <- RunUMAP(data.integrated, reduction = "pca", dims = 1:200)
}
DefaultAssay(PBMC_T) <- 'integrated'
PBMC_T <- ProcessInt(PBMC_T)

PBMC_T_CD4 <- subset(PBMC_T, subset = predicted.celltype.l2 == c('CD8 Proliferating'), invert = T)
table(PBMC_T_CD4$predicted.celltype.l2)
PBMC_T_CD4 <- subset(PBMC_T_CD4, subset = predicted.celltype.l2 == c('CD8 TCM'), invert = T)
PBMC_T_CD4 <- subset(PBMC_T_CD4, subset = predicted.celltype.l2 == c('CD8 TEM'), invert = T)
PBMC_T_CD4 <- subset(PBMC_T_CD4, subset = predicted.celltype.l2 == c('CD8 Naive'), invert = T)
DimPlot(PBMC_T_CD4, group.by = 'predicted.celltype.l2', label = T, repel = T, label.box = T)
PBMC_T_CD4 <- ProcessInt(PBMC_T_CD4)
DimPlot(PBMC_T_CD4, group.by = 'predicted.celltype.l2', label = T, repel = T, label.box = T)

DimPlot(PBMC_T_CD4, group.by = 'oldl2', label = T, repel = T, label.box = T)
library(Azimuth)
PBMC_T_CD4_new <-  RunAzimuth(PBMC_T_CD4, reference = "pbmcref")
DimPlot(PBMC_T_CD4_new, group.by = 'predicted.celltype.l2', label = T, repel = T, label.box = T)
table(PBMC_T_CD4_new$predicted.celltype.l2)
PBMC_T_CD4_new <- subset(PBMC_T_CD4_new, subset = predicted.celltype.l2 == c('CD8 TCM'), invert = T)
PBMC_T_CD4_new <- subset(PBMC_T_CD4_new, subset = predicted.celltype.l2 == c('CD8 TEM'), invert = T)
PBMC_T_CD4_new <- subset(PBMC_T_CD4_new, subset = predicted.celltype.l2 == c('CD8 Naive'), invert = T)
table(PBMC_T_CD4_new$predicted.celltype.l2)
PBMC_T_CD4_new <- subset(PBMC_T_CD4_new, subset = predicted.celltype.l2 == c('NK'), invert = T)
PBMC_T_CD4_new <- subset(PBMC_T_CD4_new, subset = predicted.celltype.l2 == c('NK Proliferating'), invert = T)
PBMC_T_CD4_new <- ProcessInt(PBMC_T_CD4_new)

DimPlot(PBMC_T_CD4, group.by = 'predicted.celltype.l2', label = T, repel = T, label.box = T)
