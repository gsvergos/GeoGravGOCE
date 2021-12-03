function [ stats_filtered_Vij_GRF ] = stats_filtered_IIR_SGG_GRF( Vij_filtered,currentFolder)
%    GeoGravGOCE project
%    E. Mamagiannou
%    GravLab, AUTh, 27/8/2020

%    ---------------------------------------------------------------------------------------------
%    INFO
%    the function computes the statistics of the filtered Vij
%    statistics = min, max, mean, std,rms

%    *** input ***
%    Vij_filtered = the IIR filterd Vij = {6x1 cells}
%    the format of Vij_filtered.mat:
%    1st cell = Vxx
%    2nd cell = Vyy
%    3rd cell = Vzz
%    4th cell = Vxy
%    5th cell = Vxy
%    6th cell = Vyz
%    currentFolder =  the current working folder

%    *** output ***
%    As return, in the "IIR\Statistics_filtered_Vij_GRF" folder, are saved:
%    stats_filtered_Vij_GRF.mat
%    stats_filtered_Vij_GRF_Report.txt
%    ---------------------------------------------------------------------------------------------

%% classification/ Gravity Gradients after filtering, unit: Eotvos
if length(Vij_filtered{1})>1500 % load 1 file
    Vxx{1,1} = Vij_filtered{5,1};
    Vyy{1,1} = Vij_filtered{6,1};
    Vzz{1,1} = Vij_filtered{7,1};
    Vxy{1,1} = Vij_filtered{8,1};
    Vxz{1,1} = Vij_filtered{9,1};
    Vyz{1,1}= Vij_filtered{10,1};
else
    Vxx = Vij_filtered{5,1};
    Vyy = Vij_filtered{6,1};
    Vzz = Vij_filtered{7,1};
    Vxy = Vij_filtered{8,1};
    Vxz = Vij_filtered{9,1};
    Vyz= Vij_filtered{10,1};
end

% create a folder to save all the figures (.jpeg, .fig) / "Statistics_Vij_GRF"
p = 1;
foldername = sprintf('Statistics_filtered_Vij_GRF%02',p);
currentFolder1=[currentFolder, '\IIR'];
mkdir(currentFolder1, foldername);
currentFolder2=[currentFolder, '\IIR\Statistics_filtered_Vij_GRF\stats_filtered_Vij_GRF.mat'];
currentFolder3=[currentFolder, '\IIR\Statistics_filtered_Vij_GRF\stats_filtered_Vij_GRF_Report.txt'];

for i=1:length(Vxx)
    %Vxx
    % format of stats_Vxx= min, max, mean, std, rms
    stats_filtered_Vij_GRF{i,1}(1,1)=min(Vxx{i,1});
    stats_filtered_Vij_GRF{i,1}(2,1)=max(Vxx{i,1});
    stats_filtered_Vij_GRF{i,1}(3,1)=mean(Vxx{i,1});
    stats_filtered_Vij_GRF{i,1}(4,1)=std(Vxx{i,1});
    stats_filtered_Vij_GRF{i,1}(5,1)=rms(Vxx{i,1});
    
    %Vyy
    % format of stats_Vyy= min, max, mean, std, rms
    stats_filtered_Vij_GRF{i,2}(1,1)=min(Vyy{i,1});
    stats_filtered_Vij_GRF{i,2}(2,1)=max(Vyy{i,1});
    stats_filtered_Vij_GRF{i,2}(3,1)=mean(Vyy{i,1});
    stats_filtered_Vij_GRF{i,2}(4,1)=std(Vyy{i,1});
    stats_filtered_Vij_GRF{i,2}(5,1)=rms(Vyy{i,1});
    
    %Vzz
    % format of stats_Vzz= min, max, mean, std, rms
    stats_filtered_Vij_GRF{i,3}(1,1)=min(Vzz{i,1});
    stats_filtered_Vij_GRF{i,3}(2,1)=max(Vzz{i,1});
    stats_filtered_Vij_GRF{i,3}(3,1)=mean(Vzz{i,1});
    stats_filtered_Vij_GRF{i,3}(4,1)=std(Vzz{i,1});
    stats_filtered_Vij_GRF{i,3}(5,1)=rms(Vzz{i,1});
    
    %Vxy
    % format of stats_Vxy= min, max, mean, std, rms
    stats_filtered_Vij_GRF{i,4}(1,1)=min(Vxy{i,1});
    stats_filtered_Vij_GRF{i,4}(2,1)=max(Vxy{i,1});
    stats_filtered_Vij_GRF{i,4}(3,1)=mean(Vxy{i,1});
    stats_filtered_Vij_GRF{i,4}(4,1)=std(Vxy{i,1});
    stats_filtered_Vij_GRF{i,4}(5,1)=rms(Vxy{i,1});
    
    %Vxz
    % format of stats_Vxz= min, max, mean, std, rms
    stats_filtered_Vij_GRF{i,5}(1,1)=min(Vxz{i,1});
    stats_filtered_Vij_GRF{i,5}(2,1)=max(Vxz{i,1});
    stats_filtered_Vij_GRF{i,5}(3,1)=mean(Vxz{i,1});
    stats_filtered_Vij_GRF{i,5}(4,1)=std(Vxz{i,1});
    stats_filtered_Vij_GRF{i,5}(5,1)=rms(Vxz{i,1});
    
    %Vyz
    % format of stats_Vyy= min, max, mean, std, rms
    stats_filtered_Vij_GRF{i,6}(1,1)=min(Vyz{i,1});
    stats_filtered_Vij_GRF{i,6}(2,1)=max(Vyz{i,1});
    stats_filtered_Vij_GRF{i,6}(3,1)=mean(Vyz{i,1});
    stats_filtered_Vij_GRF{i,6}(4,1)=std(Vyz{i,1});
    stats_filtered_Vij_GRF{i,6}(5,1)=rms(Vyz{i,1});
end

% the correspondin report (.txt)
%fprintf(2, '\nGeoGravGOCE Info:\n')
Vij_filtered_report=' ';
Vij_filtered_report =[Vij_filtered_report, newline 'The "stats_fitered_Vij_GRF.mat" contains the statistics of the reduced filtered Vij in GRF (Eötvös):'];
Vij_filtered_report =[Vij_filtered_report, newline 'Dimensions of stats_fitered_Vij_GRF.mat: [Nx6] cells'];
Vij_filtered_report =[Vij_filtered_report, newline 'rows = N = the number of the processed files'];
Vij_filtered_report =[Vij_filtered_report, newline 'columns = 6 = the 6 reduced filtered Gravity Gradients'];
Vij_filtered_report =[Vij_filtered_report, newline ' '];
Vij_filtered_report =[Vij_filtered_report, newline '1st column / cell = statistics of reduced filtered Vxx '];
Vij_filtered_report =[Vij_filtered_report, newline '2nd column / cell = statistics of reduced filtered Vyy '];
Vij_filtered_report =[Vij_filtered_report, newline '3rd column / cell = statistics of reduced filtered Vzz '];
Vij_filtered_report =[Vij_filtered_report, newline '4th column / cell = statistics of reduced filtered Vxy '];
Vij_filtered_report =[Vij_filtered_report, newline '5th column / cell = statistics of reduced filtered Vxz '];
Vij_filtered_report =[Vij_filtered_report, newline '6th column / cell = statistics of reduced filtered Vyx '];
Vij_filtered_report =[Vij_filtered_report, newline ' '];
Vij_filtered_report =[Vij_filtered_report, newline 'each interior cell has the format: '];
Vij_filtered_report =[Vij_filtered_report, newline '1 row = min '];
Vij_filtered_report =[Vij_filtered_report, newline '2 row = max '];
Vij_filtered_report =[Vij_filtered_report, newline '3 row = mean '];
Vij_filtered_report =[Vij_filtered_report, newline '4 row = std '];
Vij_filtered_report =[Vij_filtered_report, newline '5 row = rms '];
dlmwrite (currentFolder3,Vij_filtered_report,'delimiter','');
% save
save(currentFolder2,'stats_filtered_Vij_GRF');

% message for the user/ all ok/ check the folder "Statistics filtered Vij GRF"
% for the rusluts.
Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your statistics and their corresponding report were saved in the "Statistics filtered Vij GRF" folder.';'';' Check them!'}, 'Info', 'help', Opt);

end
