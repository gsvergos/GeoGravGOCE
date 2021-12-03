function [ stats_GG_WL_MRA_Vij ] =stats_GG_WL_MRA( GG_WL,currentFolder)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 15/8/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for computation of the statistics of the reconstructions
%   ----------------------------------------------------------------------------------------
%% Folder creation
p = 1;
foldername = sprintf('Statistics_GG_WL_MRA%02',p);
currentFolder1=[currentFolder, '\Wavelets'];
mkdir(currentFolder1, foldername);
currentFolder2=[currentFolder, '\Wavelets\Statistics_GG_WL_MRA\stats_GG_WL_MRA_Vij.mat'];
currentFolder3=[currentFolder, '\Wavelets\Statistics_GG_WL_MRA\stats_GG_WL_MRA_Vij_Report'];
%% Statistics of V gradients , unit: Eötvös
% classification
synthesis_vxx_det = GG_WL{6,1};
synthesis_vyy_det = GG_WL{7,1};
synthesis_vzz_det = GG_WL{8,1};
synthesis_vxy_det = GG_WL{9,1};
synthesis_vxz_det = GG_WL{10,1};
synthesis_vyz_det = GG_WL{11,1};

%% Computation of stats
for i=1:length(synthesis_vxx_det)
    
    %synthesis_vxx_det
    % format of stats_synthesis_vxx_det= min, max, mean, std, rms
    stats_GG_WL_MRA_Vij{i,1}(1,1)=min(synthesis_vxx_det{i,1});
    stats_GG_WL_MRA_Vij{i,1}(2,1)=max(synthesis_vxx_det{i,1});
    stats_GG_WL_MRA_Vij{i,1}(3,1)=mean(synthesis_vxx_det{i,1});
    stats_GG_WL_MRA_Vij{i,1}(4,1)=std(synthesis_vxx_det{i,1});
    stats_GG_WL_MRA_Vij{i,1}(5,1)=rms(synthesis_vxx_det{i,1});
    
    %synthesis_vyy_det
    % format of stats_synthesis_vyy_det= min, max, mean, std, rms
    stats_GG_WL_MRA_Vij{i,2}(1,1)=min(synthesis_vyy_det{i,1});
    stats_GG_WL_MRA_Vij{i,2}(2,1)=max(synthesis_vyy_det{i,1});
    stats_GG_WL_MRA_Vij{i,2}(3,1)=mean(synthesis_vyy_det{i,1});
    stats_GG_WL_MRA_Vij{i,2}(4,1)=std(synthesis_vyy_det{i,1});
    stats_GG_WL_MRA_Vij{i,2}(5,1)=rms(synthesis_vyy_det{i,1});
    
    %synthesis_vzz_det
    % format of stats_synthesis_vzz_det= min, max, mean, std, rms
    stats_GG_WL_MRA_Vij{i,3}(1,1)=min(synthesis_vzz_det{i,1});
    stats_GG_WL_MRA_Vij{i,3}(2,1)=max(synthesis_vzz_det{i,1});
    stats_GG_WL_MRA_Vij{i,3}(3,1)=mean(synthesis_vzz_det{i,1});
    stats_GG_WL_MRA_Vij{i,3}(4,1)=std(synthesis_vzz_det{i,1});
    stats_GG_WL_MRA_Vij{i,3}(5,1)=rms(synthesis_vzz_det{i,1});
    
    %synthesis_vxy_det
    % format of stats_synthesis_vxy_det= min, max, mean, std, rms
    stats_GG_WL_MRA_Vij{i,4}(1,1)=min(synthesis_vxy_det{i,1});
    stats_GG_WL_MRA_Vij{i,4}(2,1)=max(synthesis_vxy_det{i,1});
    stats_GG_WL_MRA_Vij{i,4}(3,1)=mean(synthesis_vxy_det{i,1});
    stats_GG_WL_MRA_Vij{i,4}(4,1)=std(synthesis_vxy_det{i,1});
    stats_GG_WL_MRA_Vij{i,4}(5,1)=rms(synthesis_vxy_det{i,1});
    
    %synthesis_vxz_det
    % format of stats_synthesis_vxz_det= min, max, mean, std, rms
    stats_GG_WL_MRA_Vij{i,5}(1,1)=min(synthesis_vxz_det{i,1});
    stats_GG_WL_MRA_Vij{i,5}(2,1)=max(synthesis_vxz_det{i,1});
    stats_GG_WL_MRA_Vij{i,5}(3,1)=mean(synthesis_vxz_det{i,1});
    stats_GG_WL_MRA_Vij{i,5}(4,1)=std(synthesis_vxz_det{i,1});
    stats_GG_WL_MRA_Vij{i,5}(5,1)=rms(synthesis_vxz_det{i,1});
    
    
    %synthesis_vyz_det
    % format of stats_synthesis_vyz_det= min, max, mean, std, rms
    stats_GG_WL_MRA_Vij{i,6}(1,1)=min(synthesis_vyz_det{i,1});
    stats_GG_WL_MRA_Vij{i,6}(2,1)=max(synthesis_vyz_det{i,1});
    stats_GG_WL_MRA_Vij{i,6}(3,1)=mean(synthesis_vyz_det{i,1});
    stats_GG_WL_MRA_Vij{i,6}(4,1)=std(synthesis_vyz_det{i,1});
    stats_GG_WL_MRA_Vij{i,6}(5,1)=rms(synthesis_vyz_det{i,1});
    
end


% the corresponding report (.txt)
%fprintf(2, '\nGeoGravGOCE Info:\n')
Statistics_report=' ';
Statistics_report =[Statistics_report, newline 'The "stats_GG_WL_MRA_Vij.mat" contains the statistics of the Vij in GRF (Eötvös):'];
Statistics_report =[Statistics_report, newline 'Dimensions of stats_GG_WL_MRA_Vij.mat: [Nx6] cells'];
Statistics_report =[Statistics_report, newline ' '];
Statistics_report =[Statistics_report, newline 'rows = N = the number of the processed files'];
Statistics_report =[Statistics_report, newline 'columns = 6 = the 6 Gravity Gradients'];
Statistics_report =[Statistics_report, newline ' '];
Statistics_report =[Statistics_report, newline '1st column / cell = statistics of Vxx '];
Statistics_report =[Statistics_report, newline '2nd column / cell = statistics of Vyy '];
Statistics_report =[Statistics_report, newline '3rd column / cell = statistics of Vzz '];
Statistics_report =[Statistics_report, newline '4th column / cell = statistics of Vxy '];
Statistics_report =[Statistics_report, newline '5th column / cell = statistics of Vxz '];
Statistics_report =[Statistics_report, newline '6th column / cell = statistics of Vyx '];
Statistics_report =[Statistics_report, newline ' '];
Statistics_report =[Statistics_report, newline 'The format of each interior cell is: '];
Statistics_report =[Statistics_report, newline '1 row = min '];
Statistics_report =[Statistics_report, newline '2 row = max '];
Statistics_report =[Statistics_report, newline '3 row = mean '];
Statistics_report =[Statistics_report, newline '4 row = std '];
Statistics_report =[Statistics_report, newline '5 row = rms '];

dlmwrite (currentFolder3,Statistics_report,'delimiter','');
save(currentFolder2,'stats_GG_WL_MRA_Vij');

Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your statistics and their corresponding Report saved in the "Wavelets\ Statistics_GG_WL_MRA" folder.';'';' Check them!'}, 'Info', 'help', Opt);
end