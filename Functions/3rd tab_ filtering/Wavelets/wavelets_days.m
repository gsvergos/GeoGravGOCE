function [ GG_WL ]=wavelets_days(wave_reconstructed,datafordecomposition1)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 13/4/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for creating daily data files from orbital ones after WL-MRA
%   ----------------------------------------------------------------------------------------
%% Creation of folder
p = 1 ;
foldername = sprintf('Wavelets%02',p);
mkdir(foldername);
currentFolder = pwd; % Identify current folder
% add path
currentFolder=[currentFolder, '\Wavelets'];
%% Creation of days from orbits
cellsz=cellfun(@size,datafordecomposition1{7,1},'uni',false);
a=cell2mat(cellsz);
b=a(:,1);

day=zeros(length(b),1);
day(1)=b(1);
for i=2:length(b)
    day(i)=b(i)+day(i-1);
end

c=cell2mat(wave_reconstructed{1,:});
c1=cell2mat(wave_reconstructed{2,:});
c2=cell2mat(wave_reconstructed{3,:});
c3=cell2mat(wave_reconstructed{4,:});
c4=cell2mat(wave_reconstructed{5,:});
c5=cell2mat(wave_reconstructed{6,:});
c6=cell2mat(wave_reconstructed{7,:});
c7=cell2mat(wave_reconstructed{8,:});

day2=cell(length(day),1);
day2{1}=c(1:day(1));
for i=2:length(day)
    day2{i}=c(day(i-1)+1:day(i));
end

day3=cell(length(day),1);
day3{1}=c1(1:day(1));
for i=2:length(day)
    day3{i}=c1(day(i-1)+1:day(i));
end

day4=cell(length(day),1);
day4{1}=c2(1:day(1));
for i=2:length(day)
    day4{i}=c2(day(i-1)+1:day(i));
end

day5=cell(length(day),1);
day5{1}=c3(1:day(1));
for i=2:length(day)
    day5{i}=c3(day(i-1)+1:day(i));
end

day6=cell(length(day),1);
day6{1}=c4(1:day(1));
for i=2:length(day)
    day6{i}=c4(day(i-1)+1:day(i));
end

day7=cell(length(day),1);
day7{1}=c5(1:day(1));
for i=2:length(day)
    day7{i}=c5(day(i-1)+1:day(i));
end

day8=cell(length(day),1);
day8{1}=c6(1:day(1));
for i=2:length(day)
    day8{i}=c6(day(i-1)+1:day(i));
end

day9=cell(length(day),1);
day9{1}=c7(1:day(1));
for i=2:length(day)
    day9{i}=c7(day(i-1)+1:day(i));
end

dayall={day2 day3 day4 day5 day6 day7 day8 day9}';

testlength=length(datafordecomposition1);

if isequal(testlength,20)
    
    datagrftolnoffiltered{1,:}=dayall{8,1}; %lat
    datagrftolnoffiltered{2,:}=dayall{7,1}; %lon
    datagrftolnoffiltered{3,:}=datafordecomposition1{9,1}; %h
    datagrftolnoffiltered{4,:}=wave_reconstructed{9,1};    %UTC time
    datagrftolnoffiltered{5,:}=wave_reconstructed{10,1};    % name current day
    datagrftolnoffiltered{6,:} = dayall{1,1};       % Vxx in GRF
    datagrftolnoffiltered{7,:}= dayall{2,1};        % Vyy in GRF
    datagrftolnoffiltered{8,:} = dayall{3,1};       % Vzz in GRF
    datagrftolnoffiltered{9,:} = dayall{4,1};       % Vxy in GRF
    datagrftolnoffiltered{10,:} = dayall{5,1};      % Vxz in GRF
    datagrftolnoffiltered{11,:} = dayall{6,1};      % Vyz in GRF
    datagrftolnoffiltered{12,:}=datafordecomposition1{12,1};    %q1 (IRF - GRF)
    datagrftolnoffiltered{13,:}=datafordecomposition1{13,1};    %q2 (IRF - GRF)
    datagrftolnoffiltered{14,:}=datafordecomposition1{14,1};    %q3 (IRF - GRF)
    datagrftolnoffiltered{15,:}=datafordecomposition1{15,1};    %q4 (IRF - GRF)
    datagrftolnoffiltered{16,:}=datafordecomposition1{16,1};  %q1 (EFRF-IRF)
    datagrftolnoffiltered{17,:}=datafordecomposition1{17,1};  %q2 (EFRF-IRF)
    datagrftolnoffiltered{18,:}=datafordecomposition1{18,1};  %q3 (EFRF-IRF)
    datagrftolnoffiltered{19,:}=datafordecomposition1{19,1};  %q4 (EFRF-IRF)
    
    [ VIRFfiltgradients] = gradients_to_irf_filtered(datagrftolnoffiltered);
    [ VEFRFfiltgradients] = gradients_to_efrf_filtered(VIRFfiltgradients);
    [ VLNOF_gradients_filt] = gradients_to_lnof_filtered(VEFRFfiltgradients);
    
    GG_WL{1,:}=dayall{8,1};
    GG_WL{2,:}=dayall{7,1};
    GG_WL{3,:}=datafordecomposition1{9,1};
    GG_WL{4,:}=wave_reconstructed{9,1};
    GG_WL{5,:}=wave_reconstructed{10,1};
    GG_WL{6,:} = dayall{1,1};
    GG_WL{7,:} = dayall{2,1};
    GG_WL{8,:} = dayall{3,1};
    GG_WL{9,:} = dayall{4,1};
    GG_WL{10,:} = dayall{5,1};
    GG_WL{11,:} = dayall{6,1};
    GG_WL{12,:} = VLNOF_gradients_filt{6,1};
    GG_WL{13,:} = VLNOF_gradients_filt{7,1};
    GG_WL{14,:} = VLNOF_gradients_filt{8,1};
    GG_WL{15,:} = VLNOF_gradients_filt{9,1};
    GG_WL{16,:} = VLNOF_gradients_filt{10,1};
    GG_WL{17,:} = VLNOF_gradients_filt{11,1};
    currentFolder1=[currentFolder, '\GG_WL.mat'];
    save(currentFolder1,'GG_WL');
    
    % Creation of report about the GGs after WL MRA
    report=' ';
    
    report =[report, newline 'The "GG_WL.mat" contains the Vij after WL MRA (Eötvös):'];
    report =[report, newline 'Dimensions of GG_WL.mat: cell [17x1]'];
    report =[report, newline ' '];
    report =[report, newline 'subcells = 17 = latitude, longitude, height (GOCE altitude, UTC time (NOM data), the name of the current NOM day/file you process & the 6 Gravity Gradients after WL MRA in GRF and LNOF '];
    report =[report, newline ' '];
    report =[report, newline 'GG_WL{1,1} = latitude (degrees) (GRS80)'];
    report =[report, newline 'GG_WL{2,1} = longitude (degrees) (GRS80)'];
    report =[report, newline 'GG_WL{3,1} = height (meters)(GOCE altitude)'];
    report =[report, newline 'GG_WL{4,1} = UTC time (NOM data)'];
    report =[report, newline 'GG_WL{5,1} = The name of the current NOM day/file you process'];
    report =[report, newline 'GG_WL{6,1} = Vxx synthesis in GRF (Eötvös)'];
    report =[report, newline 'GG_WL{7,1} = Vyy synthesis in GRF(Eötvös)'];
    report =[report, newline 'GG_WL{8,1} = Vzz synthesis in GRF(Eötvös)'];
    report =[report, newline 'GG_WL{9,1} = Vxy synthesis in GRF(Eötvös)'];
    report =[report, newline 'GG_WL{10,1} = Vxz synthesis in GRF(Eötvös)'];
    report =[report, newline 'GG_WL{11,1} = Vyz synthesis in GRF(Eötvös)'];
    report =[report, newline 'GG_WL{12,1} = Vxx synthesis in LNOF (Eötvös)'];
    report =[report, newline 'GG_WL{13,1} = Vyy synthesis in LNOF(Eötvös)'];
    report =[report, newline 'GG_WL{14,1} = Vzz synthesis in LNOF(Eötvös)'];
    report =[report, newline 'GG_WL{15,1} = Vxy synthesis in LNOF(Eötvös)'];
    report =[report, newline 'GG_WL{16,1} = Vxz synthesis in LNOF(Eötvös)'];
    report =[report, newline 'GG_WL{17,1} = Vyz synthesis in LNOF(Eötvös)'];
    report =[report, newline ' '];
    
    currentFolder2=[currentFolder, '\GG_WL_Report.txt'];
    dlmwrite (currentFolder2,report,'delimiter','');
    
else
    % classification
    GG_WL{1,:}=dayall{8,1};
    GG_WL{2,:}=dayall{7,1};
    GG_WL{3,:}=datafordecomposition1{9,1};
    GG_WL{4,:}=wave_reconstructed{9,1};
    GG_WL{5,:}=wave_reconstructed{10,1};
    GG_WL{6,:} = dayall{1,1};
    GG_WL{7,:} = dayall{2,1};
    GG_WL{8,:} = dayall{3,1};
    GG_WL{9,:} = dayall{4,1};
    GG_WL{10,:} = dayall{5,1};
    GG_WL{11,:} = dayall{6,1};
    
    currentFolder1=[currentFolder, '\GG_WL.mat'];
    save(currentFolder1,'GG_WL');
    
    % Creation of report about the GGs after WL MRA
    report=' ';
    report =[report, newline 'GeoGravGOCE, GravLab, AUTh, 2020'];
    report =[report, newline ' '];
    report =[report, newline 'The "GG_WL.mat" contains the Vij after WL MRA (Eötvös):'];
    report =[report, newline 'Dimensions of GG_WL.mat: cell [11x1]'];
    report =[report, newline ' '];
    report =[report, newline 'subcells = 11 = latitude, longitude, height (GOCE altitude, UTC time (NOM data), the name of the current NOM day/file you process & the 6 Gravity Gradients after WL MRA '];
    report =[report, newline ' '];
    report =[report, newline 'GG_WL{1,1} = latitude (degrees) (GRS80)'];
    report =[report, newline 'GG_WL{2,1} = longitude (degrees) (GRS80)'];
    report =[report, newline 'GG_WL{3,1} = height (meters)(GOCE altitude)'];
    report =[report, newline 'GG_WL{4,1} = UTC time (NOM data)'];
    report =[report, newline 'GG_WL{5,1} = The name of the current NOM day/file you process'];
    report =[report, newline 'GG_WL{6,1} = Vxx synthesis (Eötvös)'];
    report =[report, newline 'GG_WL{7,1} = Vyy synthesis (Eötvös)'];
    report =[report, newline 'GG_WL{8,1} = Vzz synthesis (Eötvös)'];
    report =[report, newline 'GG_WL{9,1} = Vxy synthesis (Eötvös)'];
    report =[report, newline 'GG_WL{10,1} = Vxz synthesis (Eötvös)'];
    report =[report, newline 'GG_WL{11,1} = Vyz synthesis (Eötvös)'];    
    report =[report, newline ' '];
    
    currentFolder2=[currentFolder, '\GG_WL_Report.txt'];
    dlmwrite (currentFolder2,report,'delimiter','');
end
end