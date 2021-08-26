function surface_parcellation_mod(CAP_FILE, HEM, OUTPUT_DIR)

    
    disp('Calculating edges')
    
    load(CAP_FILE)
    
    GORDON_DIR = '../../data/Gordon_Data';
    neighborsfile = [GORDON_DIR, '/node_neighbors.txt'];
    
    bufsize=16384;
    [neighbors(:,1) neighbors(:,2) neighbors(:,3) neighbors(:,4) neighbors(:,5) neighbors(:,6) neighbors(:,7)] = ...
    textread([neighborsfile],'%u %u %u %u %u %u %u','delimiter',' ','bufsize',bufsize,'emptyvalue',NaN);
    neighbors = neighbors+1;
    
    
    medial_wall_path = [GORDON_DIR, '/medial_wall.',HEM,'.32k_fs_LR.func.gii'];
    medial_wall_obj = gifti(medial_wall_path);
    medial_wall = medial_wall_obj.cdata;
    
    fullgrads_medial = smooth_grad;
    fullgrads_medial(logical(medial_wall),:) = 1000;
    minimametrics = metric_minima_all(fullgrads_medial,3,neighbors);
    
    clear fullgrads_medial
    
    labels = watershed_algorithm_all_par(smooth_grad,minimametrics,200,1,neighbors);
    labels_avg = mean(labels==0,2);
    
    save(strcat(OUTPUT_DIR, '/labels'), 'labels')
    save(strcat(OUTPUT_DIR, '/labels_avg'), 'labels_avg')
    
    results = labels(~logical(medial_wall),:);
    save(strcat(OUTPUT_DIR, '/results'), 'results')
    
end