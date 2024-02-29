#!/bin/sh
# 1. Import data
# listing the files

# g.mapset location=Senegal mapset=PERMANENT

g.list rast
# importing the image subset with 7 Landsat bands and display the raster map
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC08_L2SP_205050_20210225_20210304_02_T1_SR_B1.TIF output=L8_2021f_01 resample=bilinear extent=region resolution=region --overwrite
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC08_L2SP_205050_20210225_20210304_02_T1_SR_B2.TIF output=L8_2021f_02 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC08_L2SP_205050_20210225_20210304_02_T1_SR_B3.TIF output=L8_2021f_03 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC08_L2SP_205050_20210225_20210304_02_T1_SR_B4.TIF output=L8_2021f_04 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC08_L2SP_205050_20210225_20210304_02_T1_SR_B5.TIF output=L8_2021f_05 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC08_L2SP_205050_20210225_20210304_02_T1_SR_B6.TIF output=L8_2021f_06 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC08_L2SP_205050_20210225_20210304_02_T1_SR_B7.TIF output=L8_2021f_07 extent=region resolution=region
#
g.list rast
#
# grouping data by i.group
# Set computational region to match the scene
g.region raster=L8_2021f_01 -p
# store VIZ, NIR, MIR into group/subgroup (leaving out TIR)
i.group group=L8_2021f subgroup=res_30m \
  input=L8_2021f_01,L8_2021f_02,L8_2021f_03,L8_2021f_04,L8_2021f_05,L8_2021f_06,L8_2021f_07
#
# 4. Clustering: generating signature file and report using k-means clustering algorithm
i.cluster group=L8_2021f subgroup=res_30m \
  signaturefile=cluster_L8_2021f \
  classes=10 reportfile=rep_clust_L8_2021f.txt --overwrite
# 5. Classification by i.maxlik module
#
i.maxlik group=L8_2021f subgroup=res_30m \
  signaturefile=cluster_L8_2021f \
  output=L8_2021f_cluster_classes reject=L8_2021f_cluster_reject --overwrite
#
# 6. Mapping
d.mon wx0
g.region raster=L8_2021f_cluster_classes -p
r.colors L8_2021f_cluster_classes color=roygbiv -e
# d.rast.leg L8_2014_cluster_classes
d.rast L8_2021f_cluster_classes
d.legend raster=L8_2021f_cluster_classes title="2021 February" title_fontsize=14 font="Helvetica" fontsize=12 bgcolor=white border_color=white
d.out.file output=Senegal_2021f format=jpg --overwrite
#
d.mon wx1
g.region raster=L8_2021f_cluster_classes -p
r.colors L8_2021f_cluster_reject color=rainbow -e
d.rast L8_2021f_cluster_reject
d.legend raster=L8_2021f_cluster_reject title="2021 February" title_fontsize=14 font="Helvetica" fontsize=12 bgcolor=white border_color=white
d.out.file output=Senegal_2021f_reject format=jpg --overwrite
#d.rast.leg L8_2014_cluster_reject
