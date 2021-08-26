clear all

%% surf file
SURF_FILE_DIR = '../../data/SurfFiles';
surf_file_R_path = [SURF_FILE_DIR, '/S1200.R.midthickness_MSMAll.32k_fs_LR.surf.gii'];
surf_file_L_path = [SURF_FILE_DIR, '/S1200.L.midthickness_MSMAll.32k_fs_LR.surf.gii'];

surf_file_R_obj = gifti(surf_file_R_path);
surf_file_R_coord = surf_file_R_obj.vertices;

surf_file_L_obj = gifti(surf_file_L_path);
surf_file_L_coord = surf_file_L_obj.vertices;

%% medial file
GORDON_DIR = '../../data/Gordon_Data';
medial_wall_R_path = [GORDON_DIR, '/medial_wall.R.32k_fs_LR.func.gii'];
medial_wall_R_obj = gifti(medial_wall_R_path);
medial_wall_R = medial_wall_R_obj.cdata;

medial_wall_L_path = [GORDON_DIR, '/medial_wall.L.32k_fs_LR.func.gii'];
medial_wall_L_obj = gifti(medial_wall_L_path);
medial_wall_L = medial_wall_L_obj.cdata;

%% mask
surf_file_R_coord = surf_file_R_coord(~medial_wall_R,:);
surf_file_L_coord = surf_file_L_coord(~medial_wall_L,:);

%% Load Gordon parcellation results
GORDON_DATA_DIR = '../../results/parcellation/gordon'
load([GORDON_DATA_DIR, '/GORDON_LEFT.mat'])
load([GORDON_DATA_DIR, '/GORDON_RIGHT.mat'])

%% get coordinate frome each labels
% LEFT
GORDON_LEFT_LABEL_COORDINATE = {};
for ilabel = 1:max(GORDON_LEFT)
    
    index = GORDON_LEFT == ilabel;
    if sum(index) == 0
        continue
    end
    ilabel_coord = surf_file_L_coord(index,:);
    GORDON_LEFT_LABEL_COORDINATE{1, ilabel} = ilabel_coord;
end
clear index ilabel_coord ilabel

% RIGHT
GORDON_RIGHT_LABEL_COORDINATE = {};
for ilabel = 1:max(GORDON_RIGHT)
    
    index = GORDON_RIGHT == ilabel;
    if sum(index) == 0
        continue
    end
    ilabel_coord = surf_file_R_coord(index,:);
    GORDON_RIGHT_LABEL_COORDINATE{1, ilabel} = ilabel_coord;
end
clear index ilabel_coord ilabel

SAVE_DIR = '../../results/coordinate_parcellation/gordon_roi';
save_gordon_right_path = [SAVE_DIR, '/GORDON_RIGHT_LABEL_COORDINATE.mat']
save_gordon_left_path = [SAVE_DIR, '/GORDON_LEFT_LABEL_COORDINATE.mat']

save(save_gordon_right_path, 'GORDON_RIGHT_LABEL_COORDINATE')
save(save_gordon_left_path, 'GORDON_LEFT_LABEL_COORDINATE')
