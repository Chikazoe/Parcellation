clear all;
addpath('/home/chikazoe/nishiyama/parcellation-nishiyama/Gordon2016Surface_parcellation_distribute-20agwt4/cifti-matlab-master')

%% medial file
GORDON_DIR = '/home/chikazoe/nishiyama/parcellation-nishiyama/Gordon2016Surface_parcellation_distribute-20agwt4';
medial_wall_R_path = [GORDON_DIR, '/medial_wall.R.32k_fs_LR.func.gii'];
medial_wall_R_obj = gifti(medial_wall_R_path);
medial_wall_R = medial_wall_R_obj.cdata;

medial_wall_L_path = [GORDON_DIR, '/medial_wall.L.32k_fs_LR.func.gii'];
medial_wall_L_obj = gifti(medial_wall_L_path);
medial_wall_L = medial_wall_L_obj.cdata;

%% Load ours data
LOAD_DIR = '/media/chikazoe/nas53/nishiyama/Parcellation_Results/Visualization';

mapped_ours_left_path = 'ours_left_mapping_gordon_ne.mat';
mapped_ours_right_path = 'ours_right_mapping_gordon_ne.mat';

load([LOAD_DIR, '/', mapped_ours_left_path])
load([LOAD_DIR, '/', mapped_ours_right_path])

%% gifti
gifti_left_obj = gifti('/media/chikazoe/nas53/nishiyama/Parcellation_Results/parcel_creator/L/L_0.5.func.gii');
gifti_right_obj = gifti('/media/chikazoe/nas53/nishiyama/Parcellation_Results/parcel_creator/L/L_0.5.func.gii');
ours_left_gifti = gifti_left_obj.cdata;
ours_right_gifti = gifti_right_obj.cdata;


load('/media/chikazoe/nas53/nishiyama/Parcellation_Results/Visualization/ours_left_mapping_gordon_ne.mat')
load('/media/chikazoe/nas53/nishiyama/Parcellation_Results/Visualization/ours_right_mapping_gordon_ne.mat')


%% mask
ours_left_gifti(~medial_wall_L,:) = single(ours_left_mapping_gordon);
ours_right_gifti(~medial_wall_R,:) = single(ours_right_mapping_gordon);
% 
% gifti_left_obj.cdata = ours_left_gifti;
% gifti_right_obj.cdata = ours_right_gifti;

%% save
SAVE_DIR = '/media/chikazoe/nas53/nishiyama/Parcellation_Results/mapped_gifti'
save(gifti(ours_left_gifti),[SAVE_DIR, '/ours_left_mapped_gordon.func.gii']);
save(gifti(ours_right_gifti),[SAVE_DIR, '/ours_right_mapped_gordon.func.gii']);

% save([SAVE_DIR, '/ours_left_mapped_gordon.func.gii'], 'gifti_left_obj')
% save([SAVE_DIR, '/ours_right_mapped_gordon.func.gii'], 'gifti_right_obj')