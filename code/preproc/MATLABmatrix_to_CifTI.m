%% This code makes surface EPI format

%% addpath
addpath(genpath('/media/chikazoe/nas53/narita/matlab_package'))
%% load "HCP_S1200_997_tfMRI_ALLTASKS_level2_cohensd_hp200_s4_MSMAll.dscalar" used for template
template = ft_read_cifti('../../data/source-data/HCP_S1200_997_tfMRI_ALLTASKS_level2_cohensd_hp200_s4_MSMAll.dscalar.nii');

%% delete unrequire fields
field_names_of_template = fieldnames( template );

deletelist1 = field_names_of_template(2:63,1);
deletelist2 = field_names_of_template(65:87,1);
clear field_names_of_template;

for rm=1:1:62
    template = rmfield( template, deletelist1{rm,1} );
end
clear rm  deletelist1;

for rm=1:1:23
    template = rmfield( template, deletelist2{rm,1} );
end
clear rm  deletelist2;

%% caluculate NaN Place of Template
nanplace = isnan( template.tfmri_language_math );
amount_of_NaN = nnz( nanplace );

%% load target
%load('/media/chikazoe/new_nas/narita/brain_parcellation/output/corr_gradient/127731/R_corrmat.mat')
load('../../data/source-data/WholebrainSubSpecificCAPs_30.mat')
mat = SUBCAPS;

target = {mat};


%% replicate template
for run=1:1:size(target,2)
    
    template_runs{1,run} = template;
    
end
clear run template;

disp('target num')
disp(size(target))
%% insert the target to the template
for run=1:1:size(target,2)
    disp(run)
    %%%
    disp('pattern num')
    for pattern_num=1:1:size( target{1,run}, 2) 
        template_runs{1,run}.( 'target' + string(pattern_num) ) = template_runs{1,run}.tfmri_language_math; 

        insertvertex=1;
        for vertex_number = 1:1:96854

            if  insertvertex<=59412 && nanplace(vertex_number,1) == 0 
                template_runs{1,run}.( 'target' + string(pattern_num) )(vertex_number,1) = target{1,run}(insertvertex, pattern_num);  
                insertvertex = insertvertex+1;
            end
            
            if insertvertex>59412 && nanplace(vertex_number,1) == 0
               template_runs{1,run}.( 'target' + string(pattern_num) )(vertex_number,1) = 0;  
               insertvertex = insertvertex+1;  
            end

        end
    end
    clear pattern_num;
    
    disp('cifti save')
    %%% save CIfTI files
    cd('../../Preproc/cifti_temp'); 

    for i=1:1:size( target{1,run}, 2) 
        ft_write_cifti( strcat('target_run', char(string(run)), '_no', char( string(i) ), '.nii'), template_runs{1,run} , 'parameter', strcat('target', char( string(i) ) ), 'precision', 'double');
    end
    clear i;

    disp('pre merge')
    %%% merge saved CIfTI files into one CIfti file
    alllist=[];
    for i=1:1:size( target{1,run}, 2) 
        alllist = strcat( alllist, ' -cifti target_run', char(string(run)), '_no', char(string(i)), '.dscalar.nii'); 
    end
    clear i;
    
    disp('cifti merge')
    system( [ strcat('wb_command -cifti-merge target_run', char(string(run)), '_all.dscalar.nii ', alllist) ] ); 
    clear alllist;
    
end
clear run;