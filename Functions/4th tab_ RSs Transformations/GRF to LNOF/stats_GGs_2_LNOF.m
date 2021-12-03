function [ stats_GGs_transf_LNOF ] =stats_GGs_2_LNOF( VLNOF_gradients,currentFolder)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 28/9/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for computation of statistics of gravity gradients transformed in LNOF
%   ----------------------------------------------------------------------------------------
%% Creation of folder
p = 1;
foldername = sprintf('Statistics_GGs_in_LNOF%02',p);
currentFolder1=[currentFolder, '\RSs Transformations - to LNOF'];
mkdir(currentFolder1, foldername);
currentFolder2=[currentFolder, '\RSs Transformations - to LNOF\Statistics_GGs_in_LNOF\stats_GGs_transf_LNOF.mat'];
currentFolder3=[currentFolder, '\RSs Transformations - to LNOF\Statistics_GGs_in_LNOF\stats_GGs_transf_LNOF_Report'];

% Statistics of V gradients in LNOF , unit: Eötvös
% classification
Vxx = VLNOF_gradients{6,1};
Vyy = VLNOF_gradients{7,1};
Vzz = VLNOF_gradients{8,1};
Vxy = VLNOF_gradients{9,1};
Vxz = VLNOF_gradients{10,1};
Vyz = VLNOF_gradients{11,1};

for i=1:length(Vxx)
    
    %Vxx
    % format of stats_Vxx= min, max, mean, std, rms
    stats_GGs_transf_LNOF{i,1}(1,1)=min(Vxx{i,1});
    stats_GGs_transf_LNOF{i,1}(2,1)=max(Vxx{i,1});
    stats_GGs_transf_LNOF{i,1}(3,1)=mean(Vxx{i,1});
    stats_GGs_transf_LNOF{i,1}(4,1)=std(Vxx{i,1});
    stats_GGs_transf_LNOF{i,1}(5,1)=rms(Vxx{i,1});
    
    %Vyy
    % format of stats_Vyy= min, max, mean, std, rms
    stats_GGs_transf_LNOF{i,2}(1,1)=min(Vyy{i,1});
    stats_GGs_transf_LNOF{i,2}(2,1)=max(Vyy{i,1});
    stats_GGs_transf_LNOF{i,2}(3,1)=mean(Vyy{i,1});
    stats_GGs_transf_LNOF{i,2}(4,1)=std(Vyy{i,1});
    stats_GGs_transf_LNOF{i,2}(5,1)=rms(Vyy{i,1});
    
    %Vzz
    % format of stats_Vzz= min, max, mean, std, rms
    stats_GGs_transf_LNOF{i,3}(1,1)=min(Vzz{i,1});
    stats_GGs_transf_LNOF{i,3}(2,1)=max(Vzz{i,1});
    stats_GGs_transf_LNOF{i,3}(3,1)=mean(Vzz{i,1});
    stats_GGs_transf_LNOF{i,3}(4,1)=std(Vzz{i,1});
    stats_GGs_transf_LNOF{i,3}(5,1)=rms(Vzz{i,1});
    
    %Vxy
    % format of stats_Vxy= min, max, mean, std, rms
    stats_GGs_transf_LNOF{i,4}(1,1)=min(Vxy{i,1});
    stats_GGs_transf_LNOF{i,4}(2,1)=max(Vxy{i,1});
    stats_GGs_transf_LNOF{i,4}(3,1)=mean(Vxy{i,1});
    stats_GGs_transf_LNOF{i,4}(4,1)=std(Vxy{i,1});
    stats_GGs_transf_LNOF{i,4}(5,1)=rms(Vxy{i,1});
    
    %Vxz
    % format of stats_Vxz= min, max, mean, std, rms
    stats_GGs_transf_LNOF{i,5}(1,1)=min(Vxz{i,1});
    stats_GGs_transf_LNOF{i,5}(2,1)=max(Vxz{i,1});
    stats_GGs_transf_LNOF{i,5}(3,1)=mean(Vxz{i,1});
    stats_GGs_transf_LNOF{i,5}(4,1)=std(Vxz{i,1});
    stats_GGs_transf_LNOF{i,5}(5,1)=rms(Vxz{i,1});
    
    
    %Vyz
    % format of stats_Vyy= min, max, mean, std, rms
    stats_GGs_transf_LNOF{i,6}(1,1)=min(Vyz{i,1});
    stats_GGs_transf_LNOF{i,6}(2,1)=max(Vyz{i,1});
    stats_GGs_transf_LNOF{i,6}(3,1)=mean(Vyz{i,1});
    stats_GGs_transf_LNOF{i,6}(4,1)=std(Vyz{i,1});
    stats_GGs_transf_LNOF{i,6}(5,1)=rms(Vyz{i,1});
    
end

% the corresponding report (.txt)
%fprintf(2, '\nGeoGravGOCE Info:\n')
Statistics_report=' ';
Statistics_report =[Statistics_report, newline 'The "stats_GGs_transf_LNOF.mat" contains the statistics of the Vij in GRF (Eötvös):'];
Statistics_report =[Statistics_report, newline 'Dimensions of stats_GGs_transf_LNOF.mat: [Nx6] cells'];
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
save(currentFolder2,'stats_GGs_transf_LNOF');

Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your statistics and their corresponding Report saved in the';'"Statistics GGs in LNOF" folder.';'';' Check them!'}, 'Info', 'help', Opt);
end