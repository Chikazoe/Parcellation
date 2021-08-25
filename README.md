# Parcellation

[提案手法名](https://www.zoelabo.com/english-home)  

## Overview


![Ours results](images/ours.png "Ours results")  
Ours parcellation results  
(画像は仮で置いています．)  
download [link](https://www.google.com)  
(現在はGoogle.comへ飛ぶようにしています)  

## Method

### Preprocessing
### Main Method

## Setting

1. このrepositoryをcloneする．
2. [GoogleDrive](https://www.google.com)からdata, resultsをダウンロードする．
3. このrepositoryのcurrent directoryへdataとresultsを移動する．


```sh
tree -L 3
```

directory structure

```sh
.
├── code
│   └── preproc
│       ├── cifti_gradient.sh
│       ├── sep_gradien_cap3000.sh
│       └── smooth.sh
├── data
│   ├── Preproc
│   │   └── target_run1_all.dscalar.nii
│   └── SurfFiles
│       ├── S1200.L.midthickness_MSMAll.32k_fs_LR.surf.gii
│       └── S1200.R.midthickness_MSMAll.32k_fs_LR.surf.gii
├── images
│   └── ours.png
├── README.md
└── results
    ├── cifti_gradient
    │   └── gradient_3000cap.dscalar.nii
    ├── separated
    │   ├── l_gradient_smooth_3000cap.func.gii
    │   └── r_gradient_smooth_3000cap.func.gii
    └── smooth
        └── gradient_smooth_3000cap.dscalar.nii
```


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
2. run_parcel_creator.m

## Requirements

- Ubuntu (18.04.5 LTS)
- MATLAB (R2019)
- wb_command (Version: 1.2.3)

## Reference
- [workbench-command](https://www.humanconnectome.org/software/workbench-command)