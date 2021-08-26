clear all;

% load old roi 
load('../../data/Glassor/ROI.mat')

ROI_1_180_vertex = 0
sum_vert=0;
for i=1:180
   ROI_size = size(ROI{1,i});
   ROI_1_180_vertex = ROI_1_180_vertex + ROI_size(1);
end

ROI_181_360_vertex=0;
for i=181:360
   ROI_size = size(ROI{1,i});
   ROI_181_360_vertex = ROI_181_360_vertex + ROI_size(1);
end

ROI_1_180_labels = zeros(ROI_1_180_vertex, 1);
for i=1:180
   indeies = ROI{1,i}; 
   ROI_1_180_labels(indeies) = i;
end

ROI_181_360_labels = zeros(ROI_181_360_vertex,1);
for i=181:360
   indeies = ROI{1,i}; 
   ROI_181_360_labels(indeies) = i;
end

save_path = '../../results/parcellation/glassor';
save([save_path, '/ROI_1_180_labels'], 'ROI_1_180_labels')
save([save_path, '/ROI_181_360_labels'], 'ROI_181_360_labels')