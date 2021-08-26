clear all;
addpath('../../lib/cifti-matlab-master')

%% medial file
GORDON_DIR = '../../data/Gordon_Data';
medial_wall_R_path = [GORDON_DIR, '/medial_wall.R.32k_fs_LR.func.gii'];
medial_wall_R_obj = gifti(medial_wall_R_path);
medial_wall_R = medial_wall_R_obj.cdata;

medial_wall_L_path = [GORDON_DIR, '/medial_wall.L.32k_fs_LR.func.gii'];
medial_wall_L_obj = gifti(medial_wall_L_path);
medial_wall_L = medial_wall_L_obj.cdata;


%% Load ours data
LOAD_DIR = '../../results/mapped_gordon';

mapped_ours_left_path = 'ours_left_mapping_gordon_32k_nonmask.mat';
mapped_ours_right_path = 'ours_right_mapping_gordon_32k_nonmask.mat';

load([LOAD_DIR, '/', mapped_ours_left_path])
load([LOAD_DIR, '/', mapped_ours_right_path])

%% mask
ours_left_mapping_gordon = ours_left_mapping_gordon(~medial_wall_L,:);
ours_right_mapping_gordon = ours_right_mapping_gordon(~medial_wall_R,:);

%% Load Gordon
GORDON_RESULT_DIR = '../../data/Gordon_Data';
gordon_dlabel_path = 'Gordon333.32k_fs_LR.dlabel.nii';
gordon_parcel_result_path = [GORDON_RESULT_DIR, '/', gordon_dlabel_path];
wbcommand = '/usr/bin/wb_command';

gordon_parcel = ciftiopen(gordon_parcel_result_path, wbcommand);
gordon_parcel_data = gordon_parcel.cdata;

gordon_parcel_data(1:29696) = single(ours_left_mapping_gordon);
gordon_parcel_data(29697:59412) = single(ours_right_mapping_gordon);

save_dir = '/media/chikazoe/nas53/nishiyama/Parcellation_Results/Visualization/mapped_gordon';
% save_path = [save_dir, '/ours_label_mapped_from_gordon.dlabel.nii'];

OUTPUTNAME = 'ours_label_mapped_from_gordon_32k_nonmask.dlabel.nii';
gordon_parcel.cdata = gordon_parcel_data;
ciftisave(gordon_parcel,OUTPUTNAME,wbcommand);
