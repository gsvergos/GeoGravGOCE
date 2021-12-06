function [ VEFRFfiltgradients] = gradients_to_efrf_filtered(VIRFfiltgradients)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 28/9/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function that computes the transformation from IRF to EFRF
%   using the output of the gradients_to_irf_filtered function
%   ----------------------------------------------------------------------------------------
%% Load quaternion data, also load the gravity gradients in IRF computed in the GRF to IRF transformation (VxxIRF,VxyIRF etc)
lat=VIRFfiltgradients{1,1};
lon=VIRFfiltgradients{2,1};
h=VIRFfiltgradients{3,1};
time_utc_nom_fractional_new=VIRFfiltgradients{4,1};
name_current_day=VIRFfiltgradients{5,1};
VxxIRF=VIRFfiltgradients{6,1};
VyyIRF=VIRFfiltgradients{7,1};
VzzIRF=VIRFfiltgradients{8,1};
VxyIRF=VIRFfiltgradients{9,1};
VxzIRF=VIRFfiltgradients{10,1};
VyzIRF=VIRFfiltgradients{11,1};
q1int=VIRFfiltgradients{16,1};
q2int=VIRFfiltgradients{17,1};
q3int=VIRFfiltgradients{18,1};
q4int=VIRFfiltgradients{19,1};

%preallocations
Vxxefrf=cell(length(lon),1);
Vxyefrf=cell(length(lon),1);
Vxzefrf=cell(length(lon),1);
Vyyefrf=cell(length(lon),1);
Vyzefrf=cell(length(lon),1);
Vzzefrf=cell(length(lon),1);
q1_int=cell(length(lon),1);
q2_int=cell(length(lon),1);
q3_int=cell(length(lon),1);
q4_int=cell(length(lon),1);
%% Transformation IRF to EFRF
for k=1:length(lon)
    VxxIRF_1=VxxIRF{k,1};
    VxyIRF_1=VxyIRF{k,1};
    VxzIRF_1=VxzIRF{k,1};
    VyyIRF_1=VyyIRF{k,1};
    VyzIRF_1=VyzIRF{k,1};
    VzzIRF_1=VzzIRF{k,1};
    q1int_1=q1int{k,1};
    q2int_1=q2int{k,1};
    q3int_1=q3int{k,1};
    q4int_1=q4int{k,1};
    
    % preallocation
    R=zeros(3,3,length(q1int_1));
    
    % Creation of the rotation matrix R (EFRF to IRF)
    for i=1:length(q1int_1)
        R(1,1,i)=(q1int_1(i,1)^2-q2int_1(i,1)^2-q3int_1(i,1)^2+q4int_1(i,1)^2);
        R(1,2,i)=2*(q1int_1(i,1)*q2int_1(i,1)+q3int_1(i,1)*q4int_1(i,1));
        R(1,3,i)=2*(q1int_1(i,1)*q3int_1(i,1)-q2int_1(i,1)*q4int_1(i,1));
        R(2,1,i)=2*(q1int_1(i,1)*q2int_1(i,1)-q3int_1(i,1)*q4int_1(i,1));
        R(2,2,i)=(-q1int_1(i,1)^2+q2int_1(i,1)^2-q3int_1(i,1)^2+q4int_1(i,1)^2);
        R(2,3,i)=2*(q2int_1(i,1)*q3int_1(i,1)+q1int_1(i,1)*q4int_1(i,1));
        R(3,1,i)=2*(q1int_1(i,1)*q3int_1(i,1)+q2int_1(i,1)*q4int_1(i,1));
        R(3,2,i)=2*(q2int_1(i,1)*q3int_1(i,1)-q1int_1(i,1)*q4int_1(i,1));
        R(3,3,i)=(-q1int_1(i,1)^2-q2int_1(i,1)^2+q3int_1(i,1)^2+q4int_1(i,1)^2);
    end
    
    
    % Creation of the VIRF matrix
    L1=length(VxxIRF_1);
    VIRF=zeros(3,3,L1);
    VIRF(1,1,:)=VxxIRF_1;
    VIRF(1,2,:)=VxyIRF_1;
    VIRF(1,3,:)=VxzIRF_1;
    VIRF(2,1,:)=VxyIRF_1;
    VIRF(2,2,:)=VyyIRF_1;
    VIRF(2,3,:)=VyzIRF_1;
    VIRF(3,1,:)=VxzIRF_1;
    VIRF(3,2,:)=VyzIRF_1;
    VIRF(3,3,:)=VzzIRF_1;
    
    
    % Creation of the VEFRF matrix
    L3=length(VxxIRF_1);
    VEFRF=zeros(3,3,L3);
    for i=1:length(VxxIRF_1)
        VEFRF(:,:,i)=(R(:,:,i)')*VIRF(:,:,i)*R(:,:,i);
    end
    
    % Extraction of the VEFRF matrix components
    VxxEFRF=VEFRF(1,1,:);
    %VxyEFRF=VEFRF(1,2,:);
    %VxzEFRF=VEFRF(1,3,:);
    VxyEFRF=VEFRF(2,1,:);
    VyyEFRF=VEFRF(2,2,:);
    %VyzEFRF=VEFRF(2,3,:);
    VxzEFRF=VEFRF(3,1,:);
    VyzEFRF=VEFRF(3,2,:);
    VzzEFRF=VEFRF(3,3,:);
    
    VxxEFRF=reshape(VxxEFRF,[length(VxxIRF_1),1]);
    VxyEFRF=reshape(VxyEFRF,[length(VxxIRF_1),1]);
    VxzEFRF=reshape(VxzEFRF,[length(VxxIRF_1),1]);
    VyyEFRF=reshape(VyyEFRF,[length(VxxIRF_1),1]);
    VyzEFRF=reshape(VyzEFRF,[length(VxxIRF_1),1]);
    VzzEFRF=reshape(VzzEFRF,[length(VxxIRF_1),1]);
    
    Vxxefrf{k,1}=VxxEFRF;
    Vxyefrf{k,1}=VxyEFRF;
    Vxzefrf{k,1}=VxzEFRF;
    Vyyefrf{k,1}=VyyEFRF;
    Vyzefrf{k,1}=VyzEFRF;
    Vzzefrf{k,1}=VzzEFRF;
    q1_int{k,1}=q1int_1;
    q2_int{k,1}=q2int_1;
    q3_int{k,1}=q3int_1;
    q4_int{k,1}=q4int_1;
end

VxxEFRF=Vxxefrf;
VxyEFRF=Vxyefrf;
VxzEFRF=Vxzefrf;
VyyEFRF=Vyyefrf;
VyzEFRF=Vyzefrf;
VzzEFRF=Vzzefrf;


VEFRFfiltgradients{1,1}=lat;
VEFRFfiltgradients{2,1}=lon;
VEFRFfiltgradients{3,1}=h;
VEFRFfiltgradients{4,1}=time_utc_nom_fractional_new;
VEFRFfiltgradients{5,1}=name_current_day;
VEFRFfiltgradients{6,1}=VxxEFRF;
VEFRFfiltgradients{7,1}=VyyEFRF;
VEFRFfiltgradients{8,1}=VzzEFRF;
VEFRFfiltgradients{9,1}=VxyEFRF;
VEFRFfiltgradients{10,1}=VxzEFRF;
VEFRFfiltgradients{11,1}=VyzEFRF;
end