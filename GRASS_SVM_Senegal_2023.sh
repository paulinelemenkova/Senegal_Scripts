#!/bin/sh
grass
# importing the image subset with 7 Landsat bands and display the raster map
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC09_L2SP_205050_20230122_20230313_02_T1_SR_B1.TIF output=L_2023_01 resample=bilinear extent=region resolution=region --overwrite
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC09_L2SP_205050_20230122_20230313_02_T1_SR_B2.TIF output=L_2023_02 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC09_L2SP_205050_20230122_20230313_02_T1_SR_B3.TIF output=L_2023_03 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC09_L2SP_205050_20230122_20230313_02_T1_SR_B4.TIF output=L_2023_04 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC09_L2SP_205050_20230122_20230313_02_T1_SR_B5.TIF output=L_2023_05 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC09_L2SP_205050_20230122_20230313_02_T1_SR_B6.TIF output=L_2023_06 extent=region resolution=region
r.import input=/Users/polinalemenkova/grassdata/Senegal/LC09_L2SP_205050_20230122_20230313_02_T1_SR_B7.TIF output=L_2023_07 extent=region resolution=region
#
g.list rast

# ---CLUSTERING AND CLASSIFICATION------------------->
# grouping data by i.group
# Set computational region to match the scene
g.region raster=L_2023_01 -p
i.group group=L_2023 subgroup=res_30m \
  input=L_2023_01,L_2023_02,L_2023_03,L_2023_04,L_2023_05,L_2023_06,L_2023_07 --overwrite
#
# Clustering: generating signature file and report using k-means clustering algorithm
i.cluster group=L_2023 subgroup=res_30m \
  signaturefile=cluster_L_2023 \
  classes=10 reportfile=rep_clust_L_2023.txt --overwrite

# Classification by i.maxlik module
i.maxlik group=L_2023 subgroup=res_30m \
  signaturefile=cluster_L_2023 \
  output=L_2023_clusters reject=L_2023_cluster_reject --overwrite
#
r.colors L_2023_clusters color=bcyr
#
# Mapping
g.region raster=L_2023_01 -p
d.mon wx0
d.rast L_2023_clusters
d.grid -g size=00:30:00 color=grey width=0.1 fontsize=16 text_color=grey
d.legend raster=L_2023_clusters title="Clusters 2023" title_fontsize=19 font="Helvetica" fontsize=17 bgcolor=white border_color=white
d.out.file output=Senegal_2023 format=jpg --overwrite
#
# Mapping rejection probability
d.mon wx1
g.region raster=L_2023_clusters -p
r.colors L_2023_cluster_reject color=rainbow -e
d.rast L_2023_cluster_reject
d.grid -g size=00:30:00 color=grey width=0.1 fontsize=16 text_color=grey
d.legend raster=L_2023_cluster_reject title="2023" title_fontsize=19 font="Helvetica" fontsize=17 bgcolor=white border_color=white
d.out.file output=Senegal_2023_reject format=jpg --overwrite
#
# --------------------- MACHINE LEARNING ------------------------>
# Using training pixels to perform a classification:

# 1. SVM ------------------------>
# train a SVC model using r.learn.train
r.learn.train group=L_2023 training_map=training_pixels \
    model_name=SVC n_estimators=500 save_model=svc_model.gz --overwrite
# perform prediction using r.learn.predict
r.learn.predict group=L_2023 load_model=svc_model.gz output=svc_classification --overwrite
# display
r.colors svc_classification color=roygbiv -e
d.mon wx0
d.rast svc_classification
d.grid -g size=00:30:00 color=grey width=0.1 fontsize=16 text_color=grey
d.legend raster=svc_classification title="SVM 2023" title_fontsize=19 font="Helvetica" fontsize=17 bgcolor=white border_color=white
d.out.file output=SVM_2023 format=jpg --overwrite
