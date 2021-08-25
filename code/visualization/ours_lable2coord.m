clear all;

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

%% load our labels
LOAD_DIR = '../../results/parcellation/ours_roi';

TH = 0.5;
ours_left_path = [LOAD_DIR, '/L', '/NEW_ROI_LEFT_th',num2str(TH),'.mat'];
ours_right_path = [LOAD_DIR, '/R', '/NEW_ROI_RIGHT_th',num2str(TH),'.mat'];

load(ours_left_path)
load(ours_right_path)

% %% masked
% ours_left_labels = NEW_ROI_LEFT(~medial_wall_L,:);
% ours_right_labels = NEW_ROI_RIGHT(~medial_wall_R,:);

ours_left_labels = NEW_ROI_LEFT;
ours_right_labels = NEW_ROI_RIGHT;

%% get coordinate frome each labels
% LEFT
OURS_LEFT_LABEL_COORDINATE = {};
for ilabel = 1:max(ours_left_labels)
    
    index = ours_left_labels == ilabel;
    if sum(index) == 0
        continue
    end
    ilabel_coord = surf_file_L_coord(index,:);
    OURS_LEFT_LABEL_COORDINATE{1, ilabel} = ilabel_coord;
end
clear index ilabel_coord ilabel

% RIGHT
OURS_RIGHT_LABEL_COORDINATE = {};
for ilabel = 1:max(ours_right_labels)
    
    index = ours_right_labels == ilabel;
    if sum(index) == 0
        continue
    end
    ilabel_coord = surf_file_R_coord(index,:);
    OURS_RIGHT_LABEL_COORDINATE{1, ilabel} = ilabel_coord;
end
clear index ilabel_coord ilabel

SAVE_DIR = '../../results/coordinate_parcellation/ours_roi';
save_ours_left_path = [SAVE_DIR, '/OURS_LEFT_LABEL_COORDINATE_',num2str(TH),'_32k.mat']
save_ours_right_path = [SAVE_DIR, '/OURS_RIGHT_LABEL_COORDINATE_',num2str(TH),'_32k.mat']

save(save_ours_left_path, 'OURS_LEFT_LABEL_COORDINATE')
save(save_ours_right_path, 'OURS_RIGHT_LABEL_COORDINATE')
