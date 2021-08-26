clear all

BASE_LOAD_DIR = '../../results/separated';
SAVE_DIR = '../../results/matfiles_from_gifti';

fprintf('convert matfile left... \n')
smooth_grad_obj_left = gifti([BASE_LOAD_DIR, '/', 'l_gradient_smooth_3000cap.func.gii']);
smooth_grad_left = smooth_grad_obj_left.cdata;
save([SAVE_DIR, '/L_CAP3000_gradient_smooth.mat'], 'smooth_grad_left')

fprintf('convert matfile right... \n')
smooth_grad_obj_right = gifti([BASE_LOAD_DIR, '/', 'r_gradient_smooth_3000cap.func.gii']);
smooth_grad_right = smooth_grad_obj_right.cdata;
save([SAVE_DIR, '/R_CAP3000_gradient_smooth.mat'], 'smooth_grad_right')
