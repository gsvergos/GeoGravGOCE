function [ VEFRFgradients] = gradients_to_efrf(datagrftolnof2)
%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 20/2/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function that computes the transformation from IRF to EFRF
%   using the output file from the gradients_to_irf function
%   ----------------------------------------------------------------------------------------
%% Load quaternion data and the gravity gradients in IRF computed in the GRF to IRF transformation (VxxIRF,VxyIRF etc)
lat=datagrftolnof2{1,1};
lon=datagrftolnof2{2,1};
h=datagrftolnof2{3,1};
time_utc_nom_fractional_new=datagrftolnof2{4,1};
name_current_day=datagrftolnof2{5,1};
VxxIRF=datagrftolnof2{6,1};
VyyIRF=datagrftolnof2{7,1};
VzzIRF=datagrftolnof2{8,1};
VxyIRF=datagrftolnof2{9,1};
VxzIRF=datagrftolnof2{10,1};
VyzIRF=datagrftolnof2{11,1};
q1int=datagrftolnof2{16,1};
q2int=datagrftolnof2{17,1};
q3int=datagrftolnof2{18,1};
q4int=datagrftolnof2{19,1};

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


VEFRFgradients{1,1}=lat;
VEFRFgradients{2,1}=lon;
VEFRFgradients{3,1}=h;
VEFRFgradients{4,1}=time_utc_nom_fractional_new;
VEFRFgradients{5,1}=name_current_day;
VEFRFgradients{6,1}=VxxEFRF;
VEFRFgradients{7,1}=VyyEFRF;
VEFRFgradients{8,1}=VzzEFRF;
VEFRFgradients{9,1}=VxyEFRF;
VEFRFgradients{10,1}=VxzEFRF;
VEFRFgradients{11,1}=VyzEFRF;
end