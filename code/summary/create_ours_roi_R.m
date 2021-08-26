clear all;

% load old roi 
load('../../data/Glassor/ROI.mat')
threshperc = 0.1:0.1:1;

for ith = 1:length(threshperc)
    labels_path = strcat('../../results/parcel_creator/R/R_',num2str(threshperc(ith)),'.func.gii')
    gifti_obj = gifti(labels_path)
    labels = gifti_obj.cdata;

    unique_labels = unique(labels);
    label_len = length(unique_labels);

    % DEBUG label_num = 2
    number_of_labels_distribution = [];

    label_cell = {};
    for iunique_vert = 1:label_len

        label_num = unique_labels(iunique_vert);


        label_indeies = labels==label_num;
        label_size = sum(label_indeies);
    %     append array
        number_of_labels_distribution = [number_of_labels_distribution; label_size];
        value = find(label_indeies);
    %     append cell
        label_cell{1,iunique_vert} = int32(value);

    end

%     NEW_ROI_LEFT = zeros(32492,1);
    NEW_ROI_RIGHT = zeros(32492,1);

    %% WARNING label 0 -> label 1
    for i=1:length(label_cell)
       indeies = label_cell{1,i}; 
       NEW_ROI_RIGHT(indeies) = i;
    end

    save_path = '../../results/parcellation/ours_roi/R';
    save([save_path, '/NEW_ROI_RIGHT_th',num2str(threshperc(ith)),'.mat'], 'NEW_ROI_RIGHT')

end