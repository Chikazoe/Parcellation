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


## Usage

### preprocessing

1. cifti_gradient.sh
2. smooth.sh
3. sep_gradien_cap3000.sh

```sh
bash cifti_gradient.sh
bash smooth.sh
bash sep_gradien_cap3000.sh
```

## Requirements

- Ubuntu (18.04.5 LTS)
- MATLAB (R2019)
- wb_command (Version: 1.2.3)
