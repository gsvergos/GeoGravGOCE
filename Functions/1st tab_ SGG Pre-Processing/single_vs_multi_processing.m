function [GG_coords_GRF,stop_process,type_processing] = single_vs_multi_processing(NOM_data_0,counter_NOM_0,PSO_data_0,counter_PSO_0,path_NOM,path_PSO)
    %   GeoGravGOCE project
    %   E. Mamagiannou
    %   GravLab, AUTh, 19/8/2020

    %   *** Single Processing / maximum=3 files ***
    %   *** Multi Processing / more than 3 files ***


    %%
    if (ischar(NOM_data_0)==1)
        %================*** (A1) SINGLE processing ***================
        % ----- (A1) single processing = (1 file / char type) -----
        [GG_coords_GRF,stop_process] = browse_data(NOM_data_0,counter_NOM_0,PSO_data_0,counter_PSO_0,path_NOM,path_PSO);
        type_processing=0;

    elseif (length(NOM_data_0)<=3)
        %================*** (A2) SINGLE processing ***================
        % ----- (A2) single processing = (more than 1 files / cell type) -----
        [GG_coords_GRF,stop_process] = single_process_up_2(NOM_data_0,PSO_data_0,counter_NOM_0,counter_PSO_0,path_NOM,path_PSO);
        type_processing=0;

    elseif (length(NOM_data_0)>3)
        %================*** (B) MULTI processing ***================
        % ----- (B2) multi processing = (more than 3 files / cell type) -----
        type_processing=1;
        [GG_coords_GRF,stop_process] = multi_process_up_3(NOM_data_0,PSO_data_0,counter_NOM_0,counter_PSO_0,path_NOM,path_PSO);

    else
        stop_process=1;
        GG_coords_GRF={}; %avoid: "outptut argument not assigned during call the function"
    end
end

