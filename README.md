# Parcellation

[proposal method's name](https://www.zoelabo.com/english-home)  

## Overview


![Ours results](images/ours.png "Ours results")  
Ours parcellation results  
(画像は仮で置いています．)  
download [link](https://www.google.com)  
(現在はGoogle.comへ飛ぶようにしています)  

## Method

### Preprocessing
CAP3000のdataに対して，cifti-gradientを行う．　　
### Main Method
surface parcellation(watershed algorithm)適用後の結果に対して，
閾値を0から1の間(step=0.1)で変動させて，parcellationを行う．

## Setting

1. このrepositoryをcloneする．
2. [GoogleDrive](https://www.google.com)からdata, resultsをダウンロードする．
3. このrepositoryのcurrent directoryへdataとresultsを移動する．

## Data

```
./data
```

- Preproc  
    target_run1_all.dscalar.nii
- SurfFiles  
    S1200.L.midthickness_MSMAll.32k_fs_LR.surf.gii  
    S1200.R.midthickness_MSMAll.32k_fs_LR.surf.gii  
- Gordon_Data  
    node_neighbors.txt  
    medial_wall.L.32k_fs_LR.func.gii  
    medial_wall.R.32k_fs_LR.func.gii  
    L.atlasroi_erode3.32k_fs_LR.shape.gii  
    R.atlasroi_erode3.32k_fs_LR.shape.gii  

## Usage

### preprocessing

```
./code/preproc
```

1. cifti_gradient.sh
2. smooth.sh
3. sep_gradien_cap3000.sh
4. gifti2mat.m

```sh
bash cifti_gradient.sh
bash smooth.sh
bash sep_gradien_cap3000.sh
```

### ours-parcellation-method

```
./code/ours-parcellation-method
```

1. run_surface_parcellation.m  
    get L and R labels.mat, labels_avg.mat and results.mat  
2. run_parcel_creator.m  
    get L and R each threshold func.gii  (th = 0-1)

### summary

```
./code/summary
```

- create_glassor_roi.m
- create_gordon_roi.m
- create_ours_roi_L.m
- create_ours_roi_R.m

### visualization

```
./code/visualization
```

reformat label num to coordinate.

- ours_lable2coord.m
- gordon_label2coord.m

color mapping into Gordon

- find_Correspondence_labels.m
    - compare_distance_coord.m

save sample results (TH=0.5)  
save_ours_roi_data_dlabels.m  
ours_label_mapped_from_gordon_32k_nonmask.dlabel.nii

## Requirements

- Ubuntu (18.04.5 LTS)
- MATLAB (R2019)
- wb_command (Version: 1.2.3)

## Reference
- gordon papers url
- glasser papers url
- [workbench-command](https://www.humanconnectome.org/software/workbench-command)
- [BARSA](https://balsa.wustl.edu/file/show/976Nr)
- [cifti matlab](https://github.com/Washington-University/cifti-matlab)