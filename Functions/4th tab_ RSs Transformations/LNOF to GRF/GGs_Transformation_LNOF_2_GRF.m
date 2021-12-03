function [ VGRF_gradients  ] = GGs_Transformation_LNOF_2_GRF(datalnoftogrf)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 28/9/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for the transformation of gravity gradients from LNOF to GRF
%   ----------------------------------------------------------------------------------------
%% Folder creation
p = 1 ;
foldername = sprintf('RSs Transformations - to GRF%02',p);
mkdir(foldername);
currentFolder = pwd; % Identify current folder
% add path
currentFolder=[currentFolder, '\RSs Transformations - to GRF'];

%% Load initial data
lat=datalnoftogrf{1,1};
lon=datalnoftogrf{2,1};
h=datalnoftogrf{3,1};
Vxx_new = datalnoftogrf{6,1};
Vyy_new = datalnoftogrf{7,1};
Vzz_new =datalnoftogrf{8,1};
Vxy_new = datalnoftogrf{9,1};
Vxz_new = datalnoftogrf{10,1};
Vyz_new = datalnoftogrf{11,1};
time_utc_nom_fractional_new = datalnoftogrf{4,1};
name_current_day = datalnoftogrf{5,1};
q1_new=datalnoftogrf{16,1};
q2_new=datalnoftogrf{17,1};
q3_new=datalnoftogrf{18,1};
q4_new=datalnoftogrf{19,1};
q1int=datalnoftogrf{12,1};
q2int=datalnoftogrf{13,1};
q3int=datalnoftogrf{14,1};
q4int=datalnoftogrf{15,1};

%% GGs processing and transformation from LNOF to GRF (as described in GOCE Level 2 Product Data Handbook and D. Piretzidis master)

% Transformation from LNOF to GRF

%preallocations
VxxGRF=cell(length(Vxx_new),1);
VxyGRF=cell(length(Vxx_new),1);
VxzGRF=cell(length(Vxx_new),1);
VyyGRF=cell(length(Vxx_new),1);
VyzGRF=cell(length(Vxx_new),1);
VzzGRF=cell(length(Vxx_new),1);

VxxIRF=cell(length(Vxx_new),1);
VxyIRF=cell(length(Vxx_new),1);
VxzIRF=cell(length(Vxx_new),1);
VyyIRF=cell(length(Vxx_new),1);
VyzIRF=cell(length(Vxx_new),1);
VzzIRF=cell(length(Vxx_new),1);

Vxxefrf_new_1=cell(length(Vxx_new),1);
Vxyefrf_new_1=cell(length(Vxx_new),1);
Vxzefrf_new_1=cell(length(Vxx_new),1);
Vyyefrf_new_1=cell(length(Vxx_new),1);
Vyzefrf_new_1=cell(length(Vxx_new),1);
Vzzefrf_new_1=cell(length(Vxx_new),1);

% load data needed for the transformation
for j=1:length(Vxx_new)
    Vxx_new_1=Vxx_new{j,1};
    Vyy_new_1=Vyy_new{j,1};
    Vzz_new_1=Vzz_new{j,1};
    Vxy_new_1=Vxy_new{j,1};
    Vxz_new_1=Vxz_new{j,1};
    Vyz_new_1=Vyz_new{j,1};
    q1_new_1=q1_new{j,1};
    q2_new_1=q2_new{j,1};
    q3_new_1=q3_new{j,1};
    q4_new_1=q4_new{j,1};
    q1int_1=q1int{j,1};
    q2int_1=q2int{j,1};
    q3int_1=q3int{j,1};
    q4int_1=q4int{j,1};
    lat_1=lat{j,1};
    lon_1=lon{j,1};
    
    
    % Preallocations (creation of zero matrices for the LNOF to GRF transformation)
    
    % create GGs matrix in EFRF
    Vxx_efrf_new_1=zeros(length(lat_1),1);
    Vyy_efrf_new_1=zeros(length(lat_1),1);
    Vxy_efrf_new_1=zeros(length(lat_1),1);
    Vxz_efrf_new_1=zeros(length(lat_1),1);
    Vyz_efrf_new_1=zeros(length(lat_1),1);
    Vzz_efrf_new_1=zeros(length(lat_1),1);
    
    % create GGs matrix in IRF
    Vxx_IRF=zeros(length(lat_1),1);
    Vyy_IRF=zeros(length(lat_1),1);
    Vxy_IRF=zeros(length(lat_1),1);
    Vxz_IRF=zeros(length(lat_1),1);
    Vyz_IRF=zeros(length(lat_1),1);
    Vzz_IRF=zeros(length(lat_1),1);
    
    % create GGs matrix in GRF
    Vxx_GRF=zeros(length(lat_1),1);
    Vyy_GRF=zeros(length(lat_1),1);
    Vxy_GRF=zeros(length(lat_1),1);
    Vxz_GRF=zeros(length(lat_1),1);
    Vyz_GRF=zeros(length(lat_1),1);
    Vzz_GRF=zeros(length(lat_1),1);
    
    % create rotation matrices for the transformation
    R_EFRF=zeros(3,3,length(lat_1));
    R_IRF=zeros(3,3,length(lat_1));
    R=zeros(3,3,length(lat_1));
    
    % Initialization of transformation
    for i=1:length(lat_1)
        
        % create the GG matrix for GGs in LNOF
        V_LNOF=[Vxx_new_1(i,1),Vxy_new_1(i,1),Vxz_new_1(i,1); Vxy_new_1(i,1),Vyy_new_1(i,1),Vyz_new_1(i,1); Vxz_new_1(i,1),Vyz_new_1(i,1),Vzz_new_1(i,1)];
        
        % Transformation LNOF to EFRF
        
        % Creation of matrix for the rotation from LNOF to EFRF note that the lat lon and h refer to the position vextor in EFRF
        R_EFRF(1,1,i)=-sind(lat_1(i,1))*cosd(lon_1(i,1));
        R_EFRF(1,2,i)=-sind(lat_1(i,1))*sind(lon_1(i,1));
        R_EFRF(1,3,i)=cosd(lat_1(i,1));
        R_EFRF(2,1,i)=sind(lon_1(i,1));
        R_EFRF(2,2,i)=-cosd(lon_1(i,1));
        R_EFRF(2,3,i)=0;
        R_EFRF(3,1,i)=cosd(lat_1(i,1))*cosd(lon_1(i,1));
        R_EFRF(3,2,i)=cosd(lat_1(i,1))*sind(lon_1(i,1));
        R_EFRF(3,3,i)=sind(lat_1(i,1));
        
        % Computation of GGs in EFRF - since the rotation matrix R_EFRF
        % corresponds to the rotation from EFRF to LNOF, the equation is as
        % follows: Vefrf=R'*Vlnof*R:
        V_efrf_new_1=(R_EFRF(:,:,i)')*V_LNOF*R_EFRF(:,:,i);
        
        Vxx_efrf_new_1(i,1)=V_efrf_new_1(1,1);
        Vxy_efrf_new_1(i,1)=V_efrf_new_1(1,2);
        Vxz_efrf_new_1(i,1)=V_efrf_new_1(1,3);
        Vyy_efrf_new_1(i,1)=V_efrf_new_1(2,2);
        Vyz_efrf_new_1(i,1)=V_efrf_new_1(2,3);
        Vzz_efrf_new_1(i,1)=V_efrf_new_1(3,3);
        
        % Transformation EFRF to IRF
        
        % Creation of matrix for the rotation from EFRF to IRF
        R_IRF(1,1,i)=q1int_1(i,1)^2 - q2int_1(i,1)^2 - q3int_1(i,1)^2 + q4int_1(i,1)^2;
        R_IRF(1,2,i)=2*(q1int_1(i,1)*q2int_1(i,1) + q3int_1(i,1)*q4int_1(i,1));
        R_IRF(1,3,i)=2*(q1int_1(i,1)*q3int_1(i,1) - q2int_1(i,1)*q4int_1(i,1));
        R_IRF(2,1,i)=2*(q1int_1(i,1)*q2int_1(i,1) - q3int_1(i,1)*q4int_1(i,1));
        R_IRF(2,2,i)=-q1int_1(i,1)^2 + q2int_1(i,1)^2 - q3int_1(i,1)^2 + q4int_1(i,1)^2;
        R_IRF(2,3,i)=2*(q2int_1(i,1)*q3int_1(i,1) + q1int_1(i,1)*q4int_1(i,1));
        R_IRF(3,1,i)=2*(q1int_1(i,1)*q3int_1(i,1) + q2int_1(i,1)*q4int_1(i,1));
        R_IRF(3,2,i)=2*(q2int_1(i,1)*q3int_1(i,1) - q1int_1(i,1)*q4int_1(i,1));
        R_IRF(3,3,i)=-q1int_1(i,1)^2 - q2int_1(i,1)^2 + q3int_1(i,1)^2 + q4int_1(i,1)^2;
        
        % Computation of GGs in IRF - since the rotation matrix R_IFRF
        % corresponds to the rotation from EFRF to IRF, the equation is as
        % follows: Virf=R*Vefrf*R':
        V_IRF=R_IRF(:,:,i)*V_efrf_new_1*(R_IRF(:,:,i)');
        
        Vxx_IRF(i,1)=V_IRF(1,1);
        Vxy_IRF(i,1)=V_IRF(1,2);
        Vxz_IRF(i,1)=V_IRF(1,3);
        Vyy_IRF(i,1)=V_IRF(2,2);
        Vyz_IRF(i,1)=V_IRF(2,3);
        Vzz_IRF(i,1)=V_IRF(3,3);
        
        
        % Transformation IRF to GRF
        
        % Creation of matrix for the rotation from IRF to GRF
        R(1,1,i)=q1_new_1(i,1)^2 - q2_new_1(i,1)^2 - q3_new_1(i,1)^2 + q4_new_1(i,1)^2;
        R(1,2,i)=2*(q1_new_1(i,1)*q2_new_1(i,1) + q3_new_1(i,1)*q4_new_1(i,1));
        R(1,3,i)=2*(q1_new_1(i,1)*q3_new_1(i,1) - q2_new_1(i,1)*q4_new_1(i,1));
        R(2,1,i)=2*(q1_new_1(i,1)*q2_new_1(i,1) - q3_new_1(i,1)*q4_new_1(i,1));
        R(2,2,i)=-q1_new_1(i,1)^2 + q2_new_1(i,1)^2 - q3_new_1(i,1)^2 + q4_new_1(i,1)^2;
        R(2,3,i)=2*(q2_new_1(i,1)*q3_new_1(i,1) + q1_new_1(i,1)*q4_new_1(i,1));
        R(3,1,i)=2*(q1_new_1(i,1)*q3_new_1(i,1) + q2_new_1(i,1)*q4_new_1(i,1));
        R(3,2,i)=2*(q2_new_1(i,1)*q3_new_1(i,1) - q1_new_1(i,1)*q4_new_1(i,1));
        R(3,3,i)=-q1_new_1(i,1)^2 - q2_new_1(i,1)^2 + q3_new_1(i,1)^2 + q4_new_1(i,1)^2;
        
        % Computation of GGs in GRF - since the rotation matrix R
        % corresponds to the rotation from IRF to GRF, the equation is as
        % follows: Vgrf=R*Virf*R':
        V_GRF=R(:,:,i)*V_IRF*(R(:,:,i)');
        
        Vxx_GRF(i,1)=V_GRF(1,1);
        Vxy_GRF(i,1)=V_GRF(1,2);
        Vxz_GRF(i,1)=V_GRF(1,3);
        Vyy_GRF(i,1)=V_GRF(2,2);
        Vyz_GRF(i,1)=V_GRF(2,3);
        Vzz_GRF(i,1)=V_GRF(3,3);
        
    end
    VxxGRF{j,1}=Vxx_GRF;
    VxyGRF{j,1}=Vxy_GRF;
    VxzGRF{j,1}=Vxz_GRF;
    VyyGRF{j,1}=Vyy_GRF;
    VyzGRF{j,1}=Vyz_GRF;
    VzzGRF{j,1}=Vzz_GRF;
    
    VxxIRF{j,1}=Vxx_IRF;
    VxyIRF{j,1}=Vxy_IRF;
    VxzIRF{j,1}=Vxz_IRF;
    VyyIRF{j,1}=Vyy_IRF;
    VyzIRF{j,1}=Vyz_IRF;
    VzzIRF{j,1}=Vzz_IRF;
    
    Vxxefrf_new_1{j,1}=Vxx_efrf_new_1;
    Vxyefrf_new_1{j,1}=Vxy_efrf_new_1;
    Vxzefrf_new_1{j,1}=Vxz_efrf_new_1;
    Vyyefrf_new_1{j,1}=Vyy_efrf_new_1;
    Vyzefrf_new_1{j,1}=Vyz_efrf_new_1;
    Vzzefrf_new_1{j,1}=Vzz_efrf_new_1;
end

% Creation of cells containing the Gravity Gradients for all loaded days in
% GRF,IRF and EFRF

Vxx_GRF=VxxGRF;
Vxy_GRF=VxyGRF;
Vxz_GRF=VxzGRF;
Vyy_GRF=VyyGRF;
Vyz_GRF=VyzGRF;
Vzz_GRF=VzzGRF;

%Vxx_IRF=VxxIRF;
%Vxy_IRF=VxyIRF;
%Vxz_IRF=VxzIRF;
%Vyy_IRF=VyyIRF;
%Vyz_IRF=VyzIRF;
%Vzz_IRF=VzzIRF;

%Vxx_efrf_new_1=Vxxefrf_new_1;
%Vxy_efrf_new_1=Vxyefrf_new_1;
%Vxz_efrf_new_1=Vxzefrf_new_1;
%Vyy_efrf_new_1=Vyyefrf_new_1;
%Vyz_efrf_new_1=Vyzefrf_new_1;
%Vzz_efrf_new_1=Vzzefrf_new_1;

% Save GGs
% in GRF
VGRF_gradients{6,1}=Vxx_GRF;
VGRF_gradients{7,1}=Vyy_GRF;
VGRF_gradients{8,1}=Vzz_GRF;
VGRF_gradients{9,1}=Vxy_GRF;
VGRF_gradients{10,1}=Vxz_GRF;
VGRF_gradients{11,1}=Vyz_GRF;

% needs for plots
VGRF_gradients{2,1}=lon;
VGRF_gradients{1,1}= lat;
VGRF_gradients{3,1}= h;
VGRF_gradients{4,1}= time_utc_nom_fractional_new;
VGRF_gradients{5,1}= name_current_day;

currentFolder1=[currentFolder, '\VGRF_gradients.mat'];
save(currentFolder1,'VGRF_gradients');

%% Creation of report about the GGs transformed from LNOF to GRF
report=' ';
report =[report, newline 'GeoGravGOCE, GravLab, AUTh, 2020'];
report =[report, newline ' '];
report =[report, newline 'The "VGRF_gradients.mat" contains the Vij in GRF(Eötvös):'];
report =[report, newline 'Dimensions of VGRF_gradients.mat: cell=[11x1] '];
report =[report, newline ' '];
report =[report, newline 'subcells = 11 = latitude,longitude,height(GOCE altitude),UTC time (NOM data),the name of the current NOM day/file you process & the 6 Gravity Gradients in LNOF '];
report =[report, newline ' '];
report =[report, newline 'VGRF_gradients{1,1} = latitude(degrees) (GRS80)'];
report =[report, newline 'VGRF_gradients{2,1} = longitude(degrees) (GRS80)'];
report =[report, newline 'VGRF_gradients{3,1} = h (meters)(GOCE altitude)(degrees) (GRS80)'];
report =[report, newline 'VGRF_gradients{4,1} = UTC time (NOM data)'];
report =[report, newline 'VGRF_gradients{5,1} = The name of the current NOM day/file you process'];
report =[report, newline 'VGRF_gradients{6,1} = Vxx in GRF (Eötvös)'];
report =[report, newline 'VGRF_gradients{7,1} = Vyy in GRF (Eötvös)'];
report =[report, newline 'VGRF_gradients{8,1} = Vzz in GRF (Eötvös)'];
report =[report, newline 'VGRF_gradients{9,1} = Vxy in GRF (Eötvös)'];
report =[report, newline 'VGRF_gradients{10,1} = Vxz in GRF (Eötvös)'];
report =[report, newline 'VGRF_gradients{11,1} = Vyz in GRF (Eötvös)'];
report =[report, newline ' '];

currentFolder2=[currentFolder, '\VGRF_gradients_Report.txt'];
dlmwrite (currentFolder2,report,'delimiter','');
end
