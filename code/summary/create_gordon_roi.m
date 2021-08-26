clear all;
addpath('../../lib/cifti-matlab-master')

gordon_parcel_result_path = '../../data/Gordon_Data/Gordon333.32k_fs_LR.dlabel.nii';
wbcommand = '/usr/bin/wb_command';
gordon_parcel = ciftiopen(gordon_parcel_result_path, wbcommand);
gordon_parcel_data = gordon_parcel.cdata;

GORDON_LEFT = gordon_parcel_data(1:29696);
GORDON_RIGHT = gordon_parcel_data(29697:59412);

SAVE_DIR = '../../results/parcellation/gordon';

save_path_left = [SAVE_DIR, '/GORDON_LEFT.mat']
save_path_right = [SAVE_DIR, '/GORDON_RIGHT.mat']

save(save_path_left, 'GORDON_LEFT')
save(save_path_right, 'GORDON_RIGHT')