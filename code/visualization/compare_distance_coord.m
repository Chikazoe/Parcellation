function dist_mean =  compare_distance_coord(seed_labels, target_labels)

    temp_dist = [];
    seed_labels_size = length(seed_labels);
    target_labels_size = length(target_labels);
    
    for iseed = 1:seed_labels_size
        a_ = seed_labels(iseed,:);
        for iterget = 1:target_labels_size
        
            b_ = target_labels(iterget,:);
            
            x = power(a_(1) - b_(1), 2);
            y = power(a_(2) - b_(2), 2);
            z = power(a_(3) - b_(3), 2);
            
            d = sqrt(x + y + z);
            
            temp_dist = [temp_dist, d];
        
        end
    end
    
    dist_mean = mean(temp_dist, 2);
    
end