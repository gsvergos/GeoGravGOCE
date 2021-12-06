function [ stats_GGM_Vij_GRF ] =stats_GGM_GRF( GGM_LNOF_2_GRF,currentFolder)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 20/2/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for computation of the statistics of the transformed GGM in GRF
%   ----------------------------------------------------------------------------------------
%% creation of folder
% make a folder to save all the figures (.jpeg) "Statistics_Vij_GRF"
p = 1;
foldername = sprintf('Statistics_Vij_GGM_GRF%02',p);
currentFolder1=[currentFolder, '\GGM Transformations'];
mkdir(currentFolder1, foldername);
currentFolder2=[currentFolder, '\GGM Transformations\Statistics_Vij_GGM_GRF\stats_GGM_Vij_GRF.mat'];
currentFolder3=[currentFolder, '\GGM Transformations\Statistics_Vij_GGM_GRF\stats_GGM_Vij_GRF_Report'];

% Statistics of V GGM gradients in GRF , unit: Eötvös
% classification
% Gravity Gradients after [length NOM = length PSO]
Vxx = GGM_LNOF_2_GRF{6,1};
Vyy = GGM_LNOF_2_GRF{7,1};
Vzz = GGM_LNOF_2_GRF{8,1};
Vxy = GGM_LNOF_2_GRF{9,1};
Vxz = GGM_LNOF_2_GRF{10,1};
Vyz = GGM_LNOF_2_GRF{11,1};

for i=1:length(Vxx)
    
    %Vxx
    % format of stats_Vxx= min, max, mean, std, rms
    stats_GGM_Vij_GRF{i,1}(1,1)=min(Vxx{i,1});
    stats_GGM_Vij_GRF{i,1}(2,1)=max(Vxx{i,1});
    stats_GGM_Vij_GRF{i,1}(3,1)=mean(Vxx{i,1});
    stats_GGM_Vij_GRF{i,1}(4,1)=std(Vxx{i,1});
    stats_GGM_Vij_GRF{i,1}(5,1)=rms(Vxx{i,1});
    
    %Vyy
    % format of stats_Vyy= min, max, mean, std, rms
    stats_GGM_Vij_GRF{i,2}(1,1)=min(Vyy{i,1});
    stats_GGM_Vij_GRF{i,2}(2,1)=max(Vyy{i,1});
    stats_GGM_Vij_GRF{i,2}(3,1)=mean(Vyy{i,1});
    stats_GGM_Vij_GRF{i,2}(4,1)=std(Vyy{i,1});
    stats_GGM_Vij_GRF{i,2}(5,1)=rms(Vyy{i,1});
    
    %Vzz
    % format of stats_Vzz= min, max, mean, std, rms
    stats_GGM_Vij_GRF{i,3}(1,1)=min(Vzz{i,1});
    stats_GGM_Vij_GRF{i,3}(2,1)=max(Vzz{i,1});
    stats_GGM_Vij_GRF{i,3}(3,1)=mean(Vzz{i,1});
    stats_GGM_Vij_GRF{i,3}(4,1)=std(Vzz{i,1});
    stats_GGM_Vij_GRF{i,3}(5,1)=rms(Vzz{i,1});
    
    %Vxy
    % format of stats_Vxy= min, max, mean, std, rms
    stats_GGM_Vij_GRF{i,4}(1,1)=min(Vxy{i,1});
    stats_GGM_Vij_GRF{i,4}(2,1)=max(Vxy{i,1});
    stats_GGM_Vij_GRF{i,4}(3,1)=mean(Vxy{i,1});
    stats_GGM_Vij_GRF{i,4}(4,1)=std(Vxy{i,1});
    stats_GGM_Vij_GRF{i,4}(5,1)=rms(Vxy{i,1});
    
    %Vxz
    % format of stats_Vxz= min, max, mean, std, rms
    stats_GGM_Vij_GRF{i,5}(1,1)=min(Vxz{i,1});
    stats_GGM_Vij_GRF{i,5}(2,1)=max(Vxz{i,1});
    stats_GGM_Vij_GRF{i,5}(3,1)=mean(Vxz{i,1});
    stats_GGM_Vij_GRF{i,5}(4,1)=std(Vxz{i,1});
    stats_GGM_Vij_GRF{i,5}(5,1)=rms(Vxz{i,1});
    
    
    %Vyz
    % format of stats_Vyy= min, max, mean, std, rms
    stats_GGM_Vij_GRF{i,6}(1,1)=min(Vyz{i,1});
    stats_GGM_Vij_GRF{i,6}(2,1)=max(Vyz{i,1});
    stats_GGM_Vij_GRF{i,6}(3,1)=mean(Vyz{i,1});
    stats_GGM_Vij_GRF{i,6}(4,1)=std(Vyz{i,1});
    stats_GGM_Vij_GRF{i,6}(5,1)=rms(Vyz{i,1});
    
end


% the corresponding report (.txt)
%fprintf(2, '\nGeoGravGOCE Info:\n')
Statistics_report=' ';
Statistics_report =[Statistics_report, newline 'The "stats_GGM_Vij_GRF.mat" contains the statistics of the Vij in GRF (Eötvös):'];
Statistics_report =[Statistics_report, newline 'Dimensions of stats_GGM_Vij_GRF.mat: [Nx6] cells'];
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

% save
dlmwrite (currentFolder3,Statistics_report,'delimiter','');
save(currentFolder2,'stats_GGM_Vij_GRF');

Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your statistics and their corresponding Report saved in the "Statistics Vij GGM GRF" folder.';'';' Check them!'}, 'Info', 'help', Opt);
end