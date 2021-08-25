clear all;

hem = 'L'
threshperc = 0.1:0.1:1;

for ith = 1:length(threshperc) 
    output_filestem = '../../results/parcel_creator/L';
    load('../../results/surface_parcellation/L/labels_avg.mat')
    parcel_creator(labels_avg,hem,threshperc(ith),output_filestem)
end

hem = 'R'
threshperc = 0.1:0.1:1;

for ith = 1:length(threshperc) 
    output_filestem = '../../results/parcel_creator/R';
    load('../../results/surface_parcellation/R/labels_avg.mat')
    parcel_creator(labels_avg,hem,threshperc(ith),output_filestem)
end