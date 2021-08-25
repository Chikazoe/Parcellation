clear all;

addpath('../../lib/cifti-matlab-master')

LEFT_CAP_FILE = '../../results/tem_matfiles_from_gifti/L_CAP3000_gradient_smooth.mat';
OUTPUT_DIR = '../../results/surface_parcellation/L';
HEM = 'L';
surface_parcellation_mod(LEFT_CAP_FILE, HEM, OUTPUT_DIR)

RIGHT_CAP_FILE = '../../results/tem_matfiles_from_gifti/R_CAP3000_gradient_smooth.mat';
OUTPUT_DIR = '../../results/surface_parcellation/R';
HEM = 'R';
surface_parcellation_mod(RIGHT_CAP_FILE, HEM, OUTPUT_DIR)