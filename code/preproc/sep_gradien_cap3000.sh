input_dir=../../results/smooth
out_dir=../../results/separated

input_filename=gradient_smooth_3000cap.dscalar.nii
out_left_filename=l_gradient_smooth_3000cap.func.gii
out_right_filename=r_gradient_smooth_3000cap.func.gii

cifti_in=$input_dir/$input_filename
metric_out_left=$out_dir/$out_left_filename
metric_out_right=$out_dir/$out_right_filename

wb_command -cifti-separate $cifti_in COLUMN -metric CORTEX_LEFT $metric_out_left -metric CORTEX_RIGHT $metric_out_right
