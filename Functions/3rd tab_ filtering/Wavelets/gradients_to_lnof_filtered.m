function [ VLNOF_gradients_filt] = gradients_to_lnof_filtered(VEFRFfiltgradients)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 28/9/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function that computes the transformation between the gradients from
%   EFRF to LNOF  using the output of the gradients_to_efrf_filtered function
%   ----------------------------------------------------------------------------------------
%% Transformation from EFRF to LNOF
% ?efore the application of the method we load the latitude and longitude of the orbital elements eg lat,lon
% Also load the gravity gradients in EFRF computed in the IRF to EFRF transformation (VxxEFRF,VxyEFRF etc)

% Load data
lat=VEFRFfiltgradients{1,1};
lon=VEFRFfiltgradients{2,1};
h=VEFRFfiltgradients{3,1};
time_utc_nom_fractional_new=VEFRFfiltgradients{4,1};
name_current_day=VEFRFfiltgradients{5,1};
VxxEFRF=VEFRFfiltgradients{6,1};
VyyEFRF=VEFRFfiltgradients{7,1};
VzzEFRF=VEFRFfiltgradients{8,1};
VxyEFRF=VEFRFfiltgradients{9,1};
VxzEFRF=VEFRFfiltgradients{10,1};
VyzEFRF=VEFRFfiltgradients{11,1};

%preallocations
Vxxlnof=cell(length(lon),1);
Vxylnof=cell(length(lon),1);
Vxzlnof=cell(length(lon),1);
Vyylnof=cell(length(lon),1);
Vyzlnof=cell(length(lon),1);
Vzzlnof=cell(length(lon),1);

% Transformation from EFRF to LNOF
for k=1:length(lon)
    lat_1=lat{k,1};
    lon_1=lon{k,1};
    VxxEFRF_1=VxxEFRF{k,1};
    VxyEFRF_1=VxyEFRF{k,1};
    VxzEFRF_1=VxzEFRF{k,1};
    VyyEFRF_1=VyyEFRF{k,1};
    VyzEFRF_1=VyzEFRF{k,1};
    VzzEFRF_1=VzzEFRF{k,1};
    
    phi=lat_1;
    dla=lon_1;
    
    % preallocations
    R=zeros(3,3,length(phi));
    
    % Creation of the rotation matrix R (EFRF to LNOF) North-West Up
    for i=1:length(phi)
        R(1,1,i)=-sind(phi(i,1))*cosd(dla(i,1));
        R(1,2,i)=-sind(phi(i,1))*sind(dla(i,1));
        R(1,3,i)=cosd(phi(i,1));
        R(2,1,i)=sind(dla(i,1));
        R(2,2,i)=-cosd(dla(i,1));
        R(2,3,i)=0;
        R(3,1,i)=cosd(phi(i,1))*cosd(dla(i,1));
        R(3,2,i)=cosd(phi(i,1))*sind(dla(i,1));
        R(3,3,i)=sind(phi(i,1));
    end
    
    
    % Creation of the VEFRF matrix
    L1=length(phi);
    VEFRF=zeros(3,3,L1);
    VEFRF(1,1,:)=VxxEFRF_1;
    VEFRF(1,2,:)=VxyEFRF_1;
    VEFRF(1,3,:)=VxzEFRF_1;
    VEFRF(2,1,:)=VxyEFRF_1;
    VEFRF(2,2,:)=VyyEFRF_1;
    VEFRF(2,3,:)=VyzEFRF_1;
    VEFRF(3,1,:)=VxzEFRF_1;
    VEFRF(3,2,:)=VyzEFRF_1;
    VEFRF(3,3,:)=VzzEFRF_1;
    
    % Creation of the VLNOF matrix
    L3=length(VxxEFRF);
    VLNOF=zeros(3,3,L3);
    for i=1:length(VxxEFRF_1)
        VLNOF(:,:,i)=(R(:,:,i))*VEFRF(:,:,i)*(R(:,:,i)');
    end
    
    % Extraction OF THE VLNOF matrix components
    VxxLNOF=VLNOF(1,1,:);
    %VxyLNOF=VLNOF(1,2,:);
    %VxzLNOF=VLNOF(1,3,:);
    VxyLNOF=VLNOF(2,1,:);
    VyyLNOF=VLNOF(2,2,:);
    %VyzLNOF=VLNOF(2,3,:);
    VxzLNOF=VLNOF(3,1,:);
    VyzLNOF=VLNOF(3,2,:);
    VzzLNOF=VLNOF(3,3,:);
    
    VxxLNOF=reshape(VxxLNOF,[length(VxxEFRF_1),1]);
    VxyLNOF=reshape(VxyLNOF,[length(VxxEFRF_1),1]);
    VxzLNOF=reshape(VxzLNOF,[length(VxxEFRF_1),1]);
    VyyLNOF=reshape(VyyLNOF,[length(VxxEFRF_1),1]);
    VyzLNOF=reshape(VyzLNOF,[length(VxxEFRF_1),1]);
    VzzLNOF=reshape(VzzLNOF,[length(VxxEFRF_1),1]);
    
    Vxxlnof{k,1}=VxxLNOF;
    Vxylnof{k,1}=VxyLNOF;
    Vxzlnof{k,1}=VxzLNOF;
    Vyylnof{k,1}=VyyLNOF;
    Vyzlnof{k,1}=VyzLNOF;
    Vzzlnof{k,1}=VzzLNOF;
end

VxxLNOF=Vxxlnof;
VxyLNOF=Vxylnof;
VxzLNOF=Vxzlnof;
VyyLNOF=Vyylnof;
VyzLNOF=Vyzlnof;
VzzLNOF=Vzzlnof;

VLNOF_gradients_filt{1,1}=lat;
VLNOF_gradients_filt{2,1}=lon;
VLNOF_gradients_filt{3,1}=h;
VLNOF_gradients_filt{4,1}=time_utc_nom_fractional_new;
VLNOF_gradients_filt{5,1}=name_current_day;
VLNOF_gradients_filt{6,1}=VxxLNOF;
VLNOF_gradients_filt{7,1}=VyyLNOF;
VLNOF_gradients_filt{8,1}=VzzLNOF;
VLNOF_gradients_filt{9,1}=VxyLNOF;
VLNOF_gradients_filt{10,1}=VxzLNOF;
VLNOF_gradients_filt{11,1}=VyzLNOF;
end

