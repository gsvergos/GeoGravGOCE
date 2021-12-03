function [ wave_decomposed  ] = wavelets_decomposition( datafordecomposition)
%   GeoGravGOCE project
%   E. Pitenis - code for extracting orbits by X.Oikonomidou & D. Piretzidis (with modifications by E.Pitenis)
%   GravLab, AUTh, 13/4/2020 
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for decomposing the original 1d signal(for the 6 gravity gradients)
%   ----------------------------------------------------------------------------------------
%% load data
tic
lon = datafordecomposition{7,1};
lat = datafordecomposition{8,1};
Vxx_new = datafordecomposition{1,1}; 
Vyy_new = datafordecomposition{2,1};
Vzz_new = datafordecomposition{3,1};
Vxy_new = datafordecomposition{4,1};
Vxz_new = datafordecomposition{5,1};
%a4=datafordecomposition{5,1};
%a5=cell2mat(a4);
%meanVxz=mean(a5);
testlength=length(datafordecomposition);
%for i=1:length(Vxz_new)
%    Vxz_new{i,1}=Vxz_new{i,1}-meanVxz;
%end
% checking if the 1st,2nd or 3rd option were chosen in the Load Reduced Data Panel
if isequal(testlength,20)
Vyz_new = datafordecomposition{20,1};
% reduce Vyz by mean of every day in our dataset
a1=datafordecomposition{20,1};
a2=cell2mat(a1);
meanVyz=mean(a2);
for i=1:length(Vyz_new)
    Vyz_new{i,1}=Vyz_new{i,1}-meanVyz;
end
elseif isequal(testlength,12)
Vyz_new = datafordecomposition{12,1};
% reduce Vyz by mean of every day in our dataset
a1=datafordecomposition{12,1};
a2=cell2mat(a1);
meanVyz=mean(a2);
for i=1:length(Vyz_new)
    Vyz_new{i,1}=Vyz_new{i,1}-meanVyz;
end  
elseif isequal(testlength,11)
Vyz_new = datafordecomposition{6,1};
end
time_utc_nom_fractional_new=datafordecomposition{10,1};
name_current_day=datafordecomposition{11,1};

lon=cell2mat(lon); %longtitude
lat=cell2mat(lat); % latitute
Vxx_new=cell2mat(Vxx_new); % Vxx
Vyy_new=cell2mat(Vyy_new); % Vyy
Vzz_new=cell2mat(Vzz_new); % Vzz
Vxy_new=cell2mat(Vxy_new); % Vxy
Vxz_new=cell2mat(Vxz_new); % Vxz
Vyz_new=cell2mat(Vyz_new); % Vyz
%% Part code for extracting orbits by X.Oikonomidou & D. Piretzidis (with modifications by E.Pitenis)
%select needed columns 
c = 1;
counter = 0;
text = 1; 
%break week data to single orbits
for i=1:(size(Vxx_new)-1)
%if ascend
if lat(i+1) > lat(i)
       res_lat(c,1) = lat(i);
       res_lon(c,1) = lon(i);
       res_Vxx_new(c,1) = Vxx_new(i);
       res_Vyy_new(c,1) = Vyy_new(i);
       res_Vzz_new(c,1) = Vzz_new(i);
       res_Vxy_new(c,1) = Vxy_new(i);
       res_Vxz_new(c,1) = Vxz_new(i);
       res_Vyz_new(c,1) = Vyz_new(i);
       %res_t1_nom(c,1)=t1_nom(i);
       c = c+ 1;
        
%if ascend, f>0 and before descend (counter==1) then type orbit
if(lat(i+1) > 0)
if(counter == 1)
counter = 0;
               text = text + 1;
               c = 1;
               
               %results_1{text-1,1}=results
                lat_1{text-1,1} =res_lat;
                lon_1{text-1,1} = res_lon;
                Vxx_new_1{text-1,1} = res_Vxx_new;
                Vyy_new_1{text-1,1} = res_Vyy_new;
                Vzz_new_1{text-1,1} = res_Vzz_new;
                Vxy_new_1{text-1,1} = res_Vxy_new;
                Vxz_new_1{text-1,1} = res_Vxz_new;
                Vyz_new_1{text-1,1} = res_Vyz_new;
                %t1_nom_1{text-1,1}=res_t1_nom;
                
               %clear results;
               clear res_lat;
               clear res_lon;
               clear res_Vxx_new;
               clear res_Vyy_new;
               clear res_Vzz_new;
               clear res_Vxy_new;
               clear res_Vxz_new;
               clear res_Vyz_new;
               clear res_t1_nom;
end
end
else %if descend
       counter = 1; 
       res_lat(c,1) = lat(i);
       res_lon(c,1) = lon(i);
       res_Vxx_new(c,1) = Vxx_new(i);
       res_Vyy_new(c,1) = Vyy_new(i);
       res_Vzz_new(c,1) = Vzz_new(i);
       res_Vxy_new(c,1) = Vxy_new(i);
       res_Vxz_new(c,1) = Vxz_new(i);
       res_Vyz_new(c,1) = Vyz_new(i);
     c = c+ 1;       
end
end
   
lat2=cell2mat(lat_1);
lat_1{length(lat_1)+1,:}=lat(length(lat2)+1:length(lat));
lon_1{length(lon_1)+1,:}=lon(length(lat2)+1:length(lon));
Vxx_new_1{length(Vxx_new_1)+1,:}=Vxx_new(length(lat2)+1:length(Vxx_new));
Vxy_new_1{length(Vxy_new_1)+1,:}=Vxy_new(length(lat2)+1:length(Vxy_new));
Vxz_new_1{length(Vxz_new_1)+1,:}=Vxz_new(length(lat2)+1:length(Vxz_new));
Vyy_new_1{length(Vyy_new_1)+1,:}=Vyy_new(length(lat2)+1:length(Vyy_new));
Vyz_new_1{length(Vyz_new_1)+1,:}=Vyz_new(length(lat2)+1:length(Vyz_new));
Vzz_new_1{length(Vzz_new_1)+1,:}=Vzz_new(length(lat2)+1:length(Vzz_new));
%% 1d Wavelet decomposition
% 1d Wavelet decomposition of the Vxx gradient along track per orbit
% preallocation
d=cell(13,1);
det_1=cell(length(lon_1),1);

for j=1:length(lon_1)
Vxx_new = Vxx_new_1{j,1};

wave=Vxx_new;

[c,l] = wavedec(wave,12,'db10');

for i=1:12
d{i,1}=wrcoef('d',c,l,'db10',i);
end

d{13,1}=wrcoef('a',c,l,'db10',12);
det_1{j,1}=d;
end

vxx_coefs=det_1;

% 1d Wavelet decomposition of the Vyy gradient along track per orbit
for j=1:length(lon_1)
Vyy_new = Vyy_new_1{j,1};

wave=Vyy_new;

[c,l] = wavedec(wave,12,'db10');

for i=1:12
d{i,1}=wrcoef('d',c,l,'db10',i);
end

d{13,1}=wrcoef('a',c,l,'db10',12);
det_1{j,1}=d;

end

vyy_coefs=det_1;

% 1d Wavelet decomposition of the Vzz gradient along track per orbit
for j=1:length(lon_1)
Vzz_new = Vzz_new_1{j,1};

wave=Vzz_new;

[c,l] = wavedec(wave,12,'db10');

for i=1:12
d{i,1}=wrcoef('d',c,l,'db10',i);
end

d{13,1}=wrcoef('a',c,l,'db10',12);
det_1{j,1}=d;
end

vzz_coefs=det_1;

% 1d Wavelet decomposition of the Vxy gradient along track per orbit
for j=1:length(lon_1)
Vxy_new = Vxy_new_1{j,1};

wave=Vxy_new;

[c,l] = wavedec(wave,12,'db10');

for i=1:12
d{i,1}=wrcoef('d',c,l,'db10',i);
end

d{13,1}=wrcoef('a',c,l,'db10',12);
det_1{j,1}=d;
end

vxy_coefs=det_1;

% 1d Wavelet decomposition of the Vxz gradient along track per orbit
for j=1:length(lon_1)
Vxz_new = Vxz_new_1{j,1};

wave=Vxz_new;

[c,l] = wavedec(wave,12,'db10');

for i=1:12
d{i,1}=wrcoef('d',c,l,'db10',i);
end

d{13,1}=wrcoef('a',c,l,'db10',12);
det_1{j,1}=d;
end

vxz_coefs=det_1;

% 1d Wavelet decomposition of the Vyz gradient along track per orbit
for j=1:length(lon_1)
Vyz_new = Vyz_new_1{j,1};

wave=Vyz_new;

[c,l] = wavedec(wave,12,'db10');

for i=1:12
d{i,1}=wrcoef('d',c,l,'db10',i);
end

d{13,1}=wrcoef('a',c,l,'db10',12);
det_1{j,1}=d;
end

vyz_coefs=det_1;

wave_decomposed{1,:}=vxx_coefs;
wave_decomposed{2,:}=vyy_coefs;
wave_decomposed{3,:}=vzz_coefs;
wave_decomposed{4,:}=vxy_coefs;
wave_decomposed{5,:}=vxz_coefs;
wave_decomposed{6,:}=vyz_coefs;
wave_decomposed{7,:}=lon_1;
wave_decomposed{8,:}=lat_1;
wave_decomposed{9,:}=time_utc_nom_fractional_new;
wave_decomposed{10,:}=name_current_day;
toc
end