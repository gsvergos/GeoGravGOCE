function [ VIRFfiltgradients] = gradients_to_irf_filtered(datagrftolnoffiltered)

%   GeoGravGOCE project
%   E. Pitenis
%   GravLab, AUTh, 28/9/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function that computes the transformation from GRF to IRF
%   ----------------------------------------------------------------------------------------
%% Load data for the GRF to IRF transformation
lat=datagrftolnoffiltered{1,1};
lon=datagrftolnoffiltered{2,1};
h=datagrftolnoffiltered{3,1};
Vxx_new = datagrftolnoffiltered{6,1};
Vyy_new = datagrftolnoffiltered{7,1};
Vzz_new =datagrftolnoffiltered{8,1};
Vxy_new = datagrftolnoffiltered{9,1};
Vxz_new = datagrftolnoffiltered{10,1};
Vyz_new = datagrftolnoffiltered{11,1};
time_utc_nom_fractional_new = datagrftolnoffiltered{4,1};
name_current_day = datagrftolnoffiltered{5,1};
q1_new=datagrftolnoffiltered{12,1};
q2_new=datagrftolnoffiltered{13,1};
q3_new=datagrftolnoffiltered{14,1};
q4_new=datagrftolnoffiltered{15,1};
q1int=datagrftolnoffiltered{16,1};
q2int=datagrftolnoffiltered{17,1};
q3int=datagrftolnoffiltered{18,1};
q4int=datagrftolnoffiltered{19,1};

%preallocations
Vxxirf=cell(length(lon),1);
Vxyirf=cell(length(lon),1);
Vxzirf=cell(length(lon),1);
Vyyirf=cell(length(lon),1);
Vyzirf=cell(length(lon),1);
Vzzirf=cell(length(lon),1);
%% Transformation GRF to IRF process
for j=1:length(lon)
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
    
    % prellocation
    R=zeros(3,3,length(q1_new_1));
    
    % Creation of rotation R matrix
    for i=1:length(q1_new_1)
        R(1,1,i)=q1_new_1(i,1)^2-q2_new_1(i,1)^2-q3_new_1(i,1)^2+q4_new_1(i,1)^2;
        R(1,2,i)=2*(q1_new_1(i,1)*q2_new_1(i,1)+q3_new_1(i,1)*q4_new_1(i,1));
        R(1,3,i)=2*(q1_new_1(i,1)*q3_new_1(i,1)-q2_new_1(i,1)*q4_new_1(i,1));
        R(2,1,i)=2*(q1_new_1(i,1)*q2_new_1(i,1)-q3_new_1(i,1)*q4_new_1(i,1));
        R(2,2,i)=-q1_new_1(i,1)^2+q2_new_1(i,1)^2-q3_new_1(i,1)^2+q4_new_1(i,1)^2;
        R(2,3,i)=2*(q2_new_1(i,1)*q3_new_1(i,1)+q1_new_1(i,1)*q4_new_1(i,1));
        R(3,1,i)=2*(q1_new_1(i,1)*q3_new_1(i,1)+q2_new_1(i,1)*q4_new_1(i,1));
        R(3,2,i)=2*(q2_new_1(i,1)*q3_new_1(i,1)-q1_new_1(i,1)*q4_new_1(i,1));
        R(3,3,i)=-q1_new_1(i,1)^2-q2_new_1(i,1)^2+q3_new_1(i,1)^2+q4_new_1(i,1)^2;
    end
    
    
    % Creation of the VGRF matrix
    L1=length(Vxx_new_1);
    VGRF=zeros(3,3,L1);
    VGRF(1,1,:)=Vxx_new_1;
    VGRF(1,2,:)=Vxy_new_1;
    VGRF(1,3,:)=Vxz_new_1;
    VGRF(2,1,:)=Vxy_new_1;
    VGRF(2,2,:)=Vyy_new_1;
    VGRF(2,3,:)=Vyz_new_1;
    VGRF(3,1,:)=Vxz_new_1;
    VGRF(3,2,:)=Vyz_new_1;
    VGRF(3,3,:)=Vzz_new_1;
    
    % Creation of the VIRF matrix
    L3=length(q1_new_1);
    VIRF=zeros(3,3,L3);
    
    for i=1:length(Vxx_new_1)
        VIRF(:,:,i)=(R(:,:,i)')*VGRF(:,:,i)*R(:,:,i);
    end
    
    % Extraction of the VIRF matrix components
    VxxIRF=VIRF(1,1,:);
    %VxyIRF=VIRF(1,2,:);
    %VxzIRF=VIRF(1,3,:);
    VxyIRF=VIRF(2,1,:);
    VyyIRF=VIRF(2,2,:);
    %VyzIRF=VIRF(2,3,:);
    VxzIRF=VIRF(3,1,:);
    VyzIRF=VIRF(3,2,:);
    VzzIRF=VIRF(3,3,:);
    
    VxxIRF=reshape(VxxIRF,[length(Vxx_new_1),1]);
    VxyIRF=reshape(VxyIRF,[length(Vxx_new_1),1]);
    VxzIRF=reshape(VxzIRF,[length(Vxx_new_1),1]);
    VyyIRF=reshape(VyyIRF,[length(Vxx_new_1),1]);
    VyzIRF=reshape(VyzIRF,[length(Vxx_new_1),1]);
    VzzIRF=reshape(VzzIRF,[length(Vxx_new_1),1]);
    
    % Save each iteration in a cell
    Vxxirf{j,1}=VxxIRF;
    Vxyirf{j,1}=VxyIRF;
    Vxzirf{j,1}=VxzIRF;
    Vyyirf{j,1}=VyyIRF;
    Vyzirf{j,1}=VyzIRF;
    Vzzirf{j,1}=VzzIRF;
end

VxxIRF=Vxxirf;
VxyIRF=Vxyirf;
VxzIRF=Vxzirf;
VyyIRF=Vyyirf;
VyzIRF=Vyzirf;
VzzIRF=Vzzirf;

VIRFfiltgradients{1,1}=lat;
VIRFfiltgradients{2,1}=lon;
VIRFfiltgradients{3,1}=h;
VIRFfiltgradients{4,1}=time_utc_nom_fractional_new;
VIRFfiltgradients{5,1}=name_current_day;
VIRFfiltgradients{6,1}=VxxIRF;
VIRFfiltgradients{7,1}=VyyIRF;
VIRFfiltgradients{8,1}=VzzIRF;
VIRFfiltgradients{9,1}=VxyIRF;
VIRFfiltgradients{10,1}=VxzIRF;
VIRFfiltgradients{11,1}=VyzIRF;
VIRFfiltgradients{12,1}=q1_new;
VIRFfiltgradients{13,1}=q2_new;
VIRFfiltgradients{14,1}=q3_new;
VIRFfiltgradients{15,1}=q4_new;
VIRFfiltgradients{16,1}=q1int;
VIRFfiltgradients{17,1}=q2int;
VIRFfiltgradients{18,1}=q3int;
VIRFfiltgradients{19,1}=q4int;
end