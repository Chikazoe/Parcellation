clear all;

%% medial file
GORDON_DIR = '../../data/Gordon_Data';
medial_wall_R_path = [GORDON_DIR, '/medial_wall.R.32k_fs_LR.func.gii'];
medial_wall_R_obj = gifti(medial_wall_R_path);
medial_wall_R = medial_wall_R_obj.cdata;

medial_wall_L_path = [GORDON_DIR, '/medial_wall.L.32k_fs_LR.func.gii'];
medial_wall_L_obj = gifti(medial_wall_L_path);
medial_wall_L = medial_wall_L_obj.cdata;

COORD_BASE_DIR = '../../results/coordinate_parcellation';
%% Load OURS
TH = 0.5;
load([COORD_BASE_DIR, '/', 'ours_roi', '/', 'OURS_LEFT_LABEL_COORDINATE_',num2str(TH),'_32k.mat'])
load([COORD_BASE_DIR, '/', 'ours_roi', '/', 'OURS_RIGHT_LABEL_COORDINATE_',num2str(TH),'_32k.mat'])


%% Load GORDON

load([COORD_BASE_DIR, '/', 'gordon_roi', '/', 'GORDON_LEFT_LABEL_COORDINATE.mat'])
load([COORD_BASE_DIR, '/', 'gordon_roi', '/', 'GORDON_RIGHT_LABEL_COORDINATE.mat'])


%% load our labels
LOAD_DIR = '../../results/parcellation/ours_roi';

ours_left_path = [LOAD_DIR, '/L', '/NEW_ROI_LEFT_th',num2str(TH),'.mat'];
ours_right_path = [LOAD_DIR, '/R', '/NEW_ROI_RIGHT_th',num2str(TH),'.mat'];

load(ours_left_path)
load(ours_right_path)


ours_left_labels = NEW_ROI_LEFT;
ours_right_labels = NEW_ROI_RIGHT;

ours_left_labels_clone = ours_left_labels;
ours_right_labels_clone = ours_right_labels;

%% compute distance
for ilabel = 1:length(OURS_LEFT_LABEL_COORDINATE)

    if ilabel == 1
        index_ = ours_left_labels == ilabel;
        ours_left_labels_clone(index_) = 0;
        continue
    end

    ours_label_coord = cell2mat(OURS_LEFT_LABEL_COORDINATE(1, ilabel));
    ours_label_coord = double(ours_label_coord);
    
    dist_dump = [];
    for jlabel = 1:length(GORDON_LEFT_LABEL_COORDINATE)
    
        gordon_label_coord = cell2mat(GORDON_LEFT_LABEL_COORDINATE(1, jlabel));
        if isempty(gordon_label_coord)
            dist_dump = [dist_dump, Inf];
            continue
        end
        gordon_label_coord = double(gordon_label_coord);
        %% compute distance
        mean_dist = compare_distance_coord(ours_label_coord, gordon_label_coord);
        dist_dump = [dist_dump, mean_dist];
    end
    
    [M,I] = min(dist_dump);
%     clear dist_dump
    
    index_ = ours_left_labels == ilabel;
    ours_left_labels_clone(index_) = I;
    GORDON_LEFT_LABEL_COORDINATE{1, I} = [];
    
end

%% compute distance
for ilabel = 1:length(OURS_RIGHT_LABEL_COORDINATE)

    if ilabel == 1
        index_ = ours_right_labels == ilabel;
        ours_right_labels_clone(index_) = 0;
        continue
    end

    ours_label_coord = cell2mat(OURS_RIGHT_LABEL_COORDINATE(1, ilabel));
    ours_label_coord = double(ours_label_coord);
    
    dist_dump = [];
    for jlabel = 1:length(GORDON_RIGHT_LABEL_COORDINATE)
    
        gordon_label_coord = cell2mat(GORDON_RIGHT_LABEL_COORDINATE(1, jlabel));
        if isempty(gordon_label_coord)
            dist_dump = [dist_dump, Inf];
            continue
        end
        gordon_label_coord = double(gordon_label_coord);
        %% compute distance
        mean_dist = compare_distance_coord(ours_label_coord, gordon_label_coord);
        dist_dump = [dist_dump, mean_dist];
    end
    
    [M,I] = min(dist_dump);
    clear dist_dump
    
    index_ = ours_right_labels == ilabel;
    ours_right_labels_clone(index_) = I;
    
    GORDON_RIGHT_LABEL_COORDINATE{1, I} = [];

end

save_path = ['../../results/mapped_gordon/ours_left_mapping_gordon_32k_nonmask.mat'];
ours_left_mapping_gordon = ours_left_labels_clone;
save(save_path, 'ours_left_mapping_gordon')

save_path = ['../../results/mapped_gordon//ours_right_mapping_gordon_32k_nonmask.mat'];
ours_right_mapping_gordon = ours_right_labels_clone;
save(save_path, 'ours_right_mapping_gordon')
