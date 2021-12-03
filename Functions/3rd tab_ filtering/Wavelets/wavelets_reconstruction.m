function [ wave_reconstructed ] = wavelets_reconstruction( dataforreconstruction, listcheck)
%   GeoGravGOCE project
%   E. Pitenis - code for extracting orbits by X.Oikonomidou & D. Piretzidis (with modifications by E.Pitenis)
%   GravLab, AUTh, 13/4/2020
%   ----------------------------------------------------------------------------------------
%   Function for reconstructing the 6 gravity gradients
%   ----------------------------------------------------------------------------------------
%% Creation of listcheck of checkboxes
l1=listcheck(1,1);
l2=listcheck(2,1);
l3=listcheck(3,1);
l4=listcheck(4,1);
l5=listcheck(5,1);
l6=listcheck(6,1);
l7=listcheck(7,1);
l8=listcheck(8,1);
l9=listcheck(9,1);
l10=listcheck(10,1);
l11=listcheck(11,1);
l12=listcheck(12,1);
l13=listcheck(13,1);

%preallocations
Vxx_synthesis_1=cell(length(dataforreconstruction{1,1}),1);
Vyy_synthesis_1=cell(length(dataforreconstruction{1,1}),1);
Vzz_synthesis_1=cell(length(dataforreconstruction{1,1}),1);
Vxy_synthesis_1=cell(length(dataforreconstruction{1,1}),1);
Vxz_synthesis_1=cell(length(dataforreconstruction{1,1}),1);
Vyz_synthesis_1=cell(length(dataforreconstruction{1,1}),1);


%% Checking of checkboxes and reconstructions based on selection of coefficients
for j=1:length(dataforreconstruction{1,1})
    if l1==1
        Vxx_d1=dataforreconstruction{1,1}{j,1}{1,1};
        Vyy_d1=dataforreconstruction{2,1}{j,1}{1,1};
        Vzz_d1=dataforreconstruction{3,1}{j,1}{1,1};
        Vxy_d1=dataforreconstruction{4,1}{j,1}{1,1};
        Vxz_d1=dataforreconstruction{5,1}{j,1}{1,1};
        Vyz_d1=dataforreconstruction{6,1}{j,1}{1,1};
    else
        Vxx_d1=zeros(length(dataforreconstruction{1,1}{j,1}{1,1}),1);
        Vyy_d1=zeros(length(dataforreconstruction{2,1}{j,1}{1,1}),1);
        Vzz_d1=zeros(length(dataforreconstruction{3,1}{j,1}{1,1}),1);
        Vxy_d1=zeros(length(dataforreconstruction{4,1}{j,1}{1,1}),1);
        Vxz_d1=zeros(length(dataforreconstruction{5,1}{j,1}{1,1}),1);
        Vyz_d1=zeros(length(dataforreconstruction{6,1}{j,1}{1,1}),1);
    end
    %if app.d2CheckBox.Value
    if l2==1
        Vxx_d2=dataforreconstruction{1,1}{j,1}{2,1};
        Vyy_d2=dataforreconstruction{2,1}{j,1}{2,1};
        Vzz_d2=dataforreconstruction{3,1}{j,1}{2,1};
        Vxy_d2=dataforreconstruction{4,1}{j,1}{2,1};
        Vxz_d2=dataforreconstruction{5,1}{j,1}{2,1};
        Vyz_d2=dataforreconstruction{6,1}{j,1}{2,1};
    else
        Vxx_d2=zeros(length(dataforreconstruction{1,1}{j,1}{1,1}),1);
        Vyy_d2=zeros(length(dataforreconstruction{2,1}{j,1}{1,1}),1);
        Vzz_d2=zeros(length(dataforreconstruction{3,1}{j,1}{1,1}),1);
        Vxy_d2=zeros(length(dataforreconstruction{4,1}{j,1}{1,1}),1);
        Vxz_d2=zeros(length(dataforreconstruction{5,1}{j,1}{1,1}),1);
        Vyz_d2=zeros(length(dataforreconstruction{6,1}{j,1}{1,1}),1);
    end
    if l3==1
        %if app.d3CheckBox.Value
        Vxx_d3=dataforreconstruction{1,1}{j,1}{3,1};
        Vyy_d3=dataforreconstruction{2,1}{j,1}{3,1};
        Vzz_d3=dataforreconstruction{3,1}{j,1}{3,1};
        Vxy_d3=dataforreconstruction{4,1}{j,1}{3,1};
        Vxz_d3=dataforreconstruction{5,1}{j,1}{3,1};
        Vyz_d3=dataforreconstruction{6,1}{j,1}{3,1};
    else
        Vxx_d3=zeros(length(dataforreconstruction{1,1}{j,1}{1,1}),1);
        Vyy_d3=zeros(length(dataforreconstruction{2,1}{j,1}{1,1}),1);
        Vzz_d3=zeros(length(dataforreconstruction{3,1}{j,1}{1,1}),1);
        Vxy_d3=zeros(length(dataforreconstruction{4,1}{j,1}{1,1}),1);
        Vxz_d3=zeros(length(dataforreconstruction{5,1}{j,1}{1,1}),1);
        Vyz_d3=zeros(length(dataforreconstruction{6,1}{j,1}{1,1}),1);
    end
    if l4==1
        %if app.d4CheckBox.Value
        Vxx_d4=dataforreconstruction{1,1}{j,1}{4,1};
        Vyy_d4=dataforreconstruction{2,1}{j,1}{4,1};
        Vzz_d4=dataforreconstruction{3,1}{j,1}{4,1};
        Vxy_d4=dataforreconstruction{4,1}{j,1}{4,1};
        Vxz_d4=dataforreconstruction{5,1}{j,1}{4,1};
        Vyz_d4=dataforreconstruction{6,1}{j,1}{4,1};
    else
        Vxx_d4=zeros(length(dataforreconstruction{1,1}{j,1}{1,1}),1);
        Vyy_d4=zeros(length(dataforreconstruction{2,1}{j,1}{1,1}),1);
        Vzz_d4=zeros(length(dataforreconstruction{3,1}{j,1}{1,1}),1);
        Vxy_d4=zeros(length(dataforreconstruction{4,1}{j,1}{1,1}),1);
        Vxz_d4=zeros(length(dataforreconstruction{5,1}{j,1}{1,1}),1);
        Vyz_d4=zeros(length(dataforreconstruction{6,1}{j,1}{1,1}),1);
    end
    if l5==1
        %if app.d5CheckBox.Value
        Vxx_d5=dataforreconstruction{1,1}{j,1}{5,1};
        Vyy_d5=dataforreconstruction{2,1}{j,1}{5,1};
        Vzz_d5=dataforreconstruction{3,1}{j,1}{5,1};
        Vxy_d5=dataforreconstruction{4,1}{j,1}{5,1};
        Vxz_d5=dataforreconstruction{5,1}{j,1}{5,1};
        Vyz_d5=dataforreconstruction{6,1}{j,1}{5,1};
    else
        Vxx_d5=zeros(length(dataforreconstruction{1,1}{j,1}{1,1}),1);
        Vyy_d5=zeros(length(dataforreconstruction{2,1}{j,1}{1,1}),1);
        Vzz_d5=zeros(length(dataforreconstruction{3,1}{j,1}{1,1}),1);
        Vxy_d5=zeros(length(dataforreconstruction{4,1}{j,1}{1,1}),1);
        Vxz_d5=zeros(length(dataforreconstruction{5,1}{j,1}{1,1}),1);
        Vyz_d5=zeros(length(dataforreconstruction{6,1}{j,1}{1,1}),1);
    end
    if l6==1
        %if app.d6CheckBox.Value
        Vxx_d6=dataforreconstruction{1,1}{j,1}{6,1};
        Vyy_d6=dataforreconstruction{2,1}{j,1}{6,1};
        Vzz_d6=dataforreconstruction{3,1}{j,1}{6,1};
        Vxy_d6=dataforreconstruction{4,1}{j,1}{6,1};
        Vxz_d6=dataforreconstruction{5,1}{j,1}{6,1};
        Vyz_d6=dataforreconstruction{6,1}{j,1}{6,1};
    else
        Vxx_d6=zeros(length(dataforreconstruction{1,1}{j,1}{1,1}),1);
        Vyy_d6=zeros(length(dataforreconstruction{2,1}{j,1}{1,1}),1);
        Vzz_d6=zeros(length(dataforreconstruction{3,1}{j,1}{1,1}),1);
        Vxy_d6=zeros(length(dataforreconstruction{4,1}{j,1}{1,1}),1);
        Vxz_d6=zeros(length(dataforreconstruction{5,1}{j,1}{1,1}),1);
        Vyz_d6=zeros(length(dataforreconstruction{6,1}{j,1}{1,1}),1);
    end
    if l7==1
        %if app.d7CheckBox.Value
        Vxx_d7=dataforreconstruction{1,1}{j,1}{7,1};
        Vyy_d7=dataforreconstruction{2,1}{j,1}{7,1};
        Vzz_d7=dataforreconstruction{3,1}{j,1}{7,1};
        Vxy_d7=dataforreconstruction{4,1}{j,1}{7,1};
        Vxz_d7=dataforreconstruction{5,1}{j,1}{7,1};
        Vyz_d7=dataforreconstruction{6,1}{j,1}{7,1};
    else
        Vxx_d7=zeros(length(dataforreconstruction{1,1}{j,1}{1,1}),1);
        Vyy_d7=zeros(length(dataforreconstruction{2,1}{j,1}{1,1}),1);
        Vzz_d7=zeros(length(dataforreconstruction{3,1}{j,1}{1,1}),1);
        Vxy_d7=zeros(length(dataforreconstruction{4,1}{j,1}{1,1}),1);
        Vxz_d7=zeros(length(dataforreconstruction{5,1}{j,1}{1,1}),1);
        Vyz_d7=zeros(length(dataforreconstruction{6,1}{j,1}{1,1}),1);
    end
    if l8==1
        %if app.d8CheckBox.Value
        Vxx_d8=dataforreconstruction{1,1}{j,1}{8,1};
        Vyy_d8=dataforreconstruction{2,1}{j,1}{8,1};
        Vzz_d8=dataforreconstruction{3,1}{j,1}{8,1};
        Vxy_d8=dataforreconstruction{4,1}{j,1}{8,1};
        Vxz_d8=dataforreconstruction{5,1}{j,1}{8,1};
        Vyz_d8=dataforreconstruction{6,1}{j,1}{8,1};
    else
        Vxx_d8=zeros(length(dataforreconstruction{1,1}{j,1}{1,1}),1);
        Vyy_d8=zeros(length(dataforreconstruction{2,1}{j,1}{1,1}),1);
        Vzz_d8=zeros(length(dataforreconstruction{3,1}{j,1}{1,1}),1);
        Vxy_d8=zeros(length(dataforreconstruction{4,1}{j,1}{1,1}),1);
        Vxz_d8=zeros(length(dataforreconstruction{5,1}{j,1}{1,1}),1);
        Vyz_d8=zeros(length(dataforreconstruction{6,1}{j,1}{1,1}),1);
    end
    if l9==1
        %if app.d9CheckBox.Value
        Vxx_d9=dataforreconstruction{1,1}{j,1}{9,1};
        Vyy_d9=dataforreconstruction{2,1}{j,1}{9,1};
        Vzz_d9=dataforreconstruction{3,1}{j,1}{9,1};
        Vxy_d9=dataforreconstruction{4,1}{j,1}{9,1};
        Vxz_d9=dataforreconstruction{5,1}{j,1}{9,1};
        Vyz_d9=dataforreconstruction{6,1}{j,1}{9,1};
    else
        Vxx_d9=zeros(length(dataforreconstruction{1,1}{j,1}{1,1}),1);
        Vyy_d9=zeros(length(dataforreconstruction{2,1}{j,1}{1,1}),1);
        Vzz_d9=zeros(length(dataforreconstruction{3,1}{j,1}{1,1}),1);
        Vxy_d9=zeros(length(dataforreconstruction{4,1}{j,1}{1,1}),1);
        Vxz_d9=zeros(length(dataforreconstruction{5,1}{j,1}{1,1}),1);
        Vyz_d9=zeros(length(dataforreconstruction{6,1}{j,1}{1,1}),1);
    end
    if l10==1
        % if app.d10CheckBox.Value
        Vxx_d10=dataforreconstruction{1,1}{j,1}{10,1};
        Vyy_d10=dataforreconstruction{2,1}{j,1}{10,1};
        Vzz_d10=dataforreconstruction{3,1}{j,1}{10,1};
        Vxy_d10=dataforreconstruction{4,1}{j,1}{10,1};
        Vxz_d10=dataforreconstruction{5,1}{j,1}{10,1};
        Vyz_d10=dataforreconstruction{6,1}{j,1}{10,1};
    else
        Vxx_d10=zeros(length(dataforreconstruction{1,1}{j,1}{1,1}),1);
        Vyy_d10=zeros(length(dataforreconstruction{2,1}{j,1}{1,1}),1);
        Vzz_d10=zeros(length(dataforreconstruction{3,1}{j,1}{1,1}),1);
        Vxy_d10=zeros(length(dataforreconstruction{4,1}{j,1}{1,1}),1);
        Vxz_d10=zeros(length(dataforreconstruction{5,1}{j,1}{1,1}),1);
        Vyz_d10=zeros(length(dataforreconstruction{6,1}{j,1}{1,1}),1);
    end
    if l11==1
        %if app.d11CheckBox.Value
        Vxx_d11=dataforreconstruction{1,1}{j,1}{11,1};
        Vyy_d11=dataforreconstruction{2,1}{j,1}{11,1};
        Vzz_d11=dataforreconstruction{3,1}{j,1}{11,1};
        Vxy_d11=dataforreconstruction{4,1}{j,1}{11,1};
        Vxz_d11=dataforreconstruction{5,1}{j,1}{11,1};
        Vyz_d11=dataforreconstruction{6,1}{j,1}{11,1};
    else
        Vxx_d11=zeros(length(dataforreconstruction{1,1}{j,1}{1,1}),1);
        Vyy_d11=zeros(length(dataforreconstruction{2,1}{j,1}{1,1}),1);
        Vzz_d11=zeros(length(dataforreconstruction{3,1}{j,1}{1,1}),1);
        Vxy_d11=zeros(length(dataforreconstruction{4,1}{j,1}{1,1}),1);
        Vxz_d11=zeros(length(dataforreconstruction{5,1}{j,1}{1,1}),1);
        Vyz_d11=zeros(length(dataforreconstruction{6,1}{j,1}{1,1}),1);
    end
    if l12==1
        %if app.d12CheckBox.Value
        Vxx_d12=dataforreconstruction{1,1}{j,1}{12,1};
        Vyy_d12=dataforreconstruction{2,1}{j,1}{12,1};
        Vzz_d12=dataforreconstruction{3,1}{j,1}{12,1};
        Vxy_d12=dataforreconstruction{4,1}{j,1}{12,1};
        Vxz_d12=dataforreconstruction{5,1}{j,1}{12,1};
        Vyz_d12=dataforreconstruction{6,1}{j,1}{12,1};
    else
        Vxx_d12=zeros(length(dataforreconstruction{1,1}{j,1}{1,1}),1);
        Vyy_d12=zeros(length(dataforreconstruction{2,1}{j,1}{1,1}),1);
        Vzz_d12=zeros(length(dataforreconstruction{3,1}{j,1}{1,1}),1);
        Vxy_d12=zeros(length(dataforreconstruction{4,1}{j,1}{1,1}),1);
        Vxz_d12=zeros(length(dataforreconstruction{5,1}{j,1}{1,1}),1);
        Vyz_d12=zeros(length(dataforreconstruction{6,1}{j,1}{1,1}),1);
    end
    if l13==1
        %if app.a12CheckBox.Value
        Vxx_a12=dataforreconstruction{1,1}{j,1}{13,1};
        Vyy_a12=dataforreconstruction{2,1}{j,1}{13,1};
        Vzz_a12=dataforreconstruction{3,1}{j,1}{13,1};
        Vxy_a12=dataforreconstruction{4,1}{j,1}{13,1};
        Vxz_a12=dataforreconstruction{5,1}{j,1}{13,1};
        Vyz_a12=dataforreconstruction{6,1}{j,1}{13,1};
    else
        Vxx_a12=zeros(length(dataforreconstruction{1,1}{j,1}{1,1}),1);
        Vyy_a12=zeros(length(dataforreconstruction{2,1}{j,1}{1,1}),1);
        Vzz_a12=zeros(length(dataforreconstruction{3,1}{j,1}{1,1}),1);
        Vxy_a12=zeros(length(dataforreconstruction{4,1}{j,1}{1,1}),1);
        Vxz_a12=zeros(length(dataforreconstruction{5,1}{j,1}{1,1}),1);
        Vyz_a12=zeros(length(dataforreconstruction{6,1}{j,1}{1,1}),1);
    end
    % Reconstructions
    final_Vxx=Vxx_d1+Vxx_d2+Vxx_d3+Vxx_d4+Vxx_d5+Vxx_d6+Vxx_d7+Vxx_d8+Vxx_d9+Vxx_d10+Vxx_d11+Vxx_d12+Vxx_a12;
    final_Vyy=Vyy_d1+Vyy_d2+Vyy_d3+Vyy_d4+Vyy_d5+Vyy_d6+Vyy_d7+Vyy_d8+Vyy_d9+Vyy_d10+Vyy_d11+Vyy_d12+Vyy_a12;
    final_Vzz=Vzz_d1+Vzz_d2+Vzz_d3+Vzz_d4+Vzz_d5+Vzz_d6+Vzz_d7+Vzz_d8+Vzz_d9+Vzz_d10+Vzz_d11+Vzz_d12+Vzz_a12;
    final_Vxy=Vxy_d1+Vxy_d2+Vxy_d3+Vxy_d4+Vxy_d5+Vxy_d6+Vxy_d7+Vxy_d8+Vxy_d9+Vxy_d10+Vxy_d11+Vxy_d12+Vxy_a12;
    final_Vxz=Vxz_d1+Vxz_d2+Vxz_d3+Vxz_d4+Vxz_d5+Vxz_d6+Vxz_d7+Vxz_d8+Vxz_d9+Vxz_d10+Vxz_d11+Vxz_d12+Vxz_a12;
    final_Vyz=Vyz_d1+Vyz_d2+Vyz_d3+Vyz_d4+Vyz_d5+Vyz_d6+Vyz_d7+Vyz_d8+Vyz_d9+Vyz_d10+Vyz_d11+Vyz_d12+Vyz_a12;
    
    Vxx_synthesis_1{j,1}=final_Vxx;
    Vyy_synthesis_1{j,1}=final_Vyy;
    Vzz_synthesis_1{j,1}=final_Vzz;
    Vxy_synthesis_1{j,1}=final_Vxy;
    Vxz_synthesis_1{j,1}=final_Vxz;
    Vyz_synthesis_1{j,1}=final_Vyz;
end

% save reconstructions in a cell
Vxx_synthesis=Vxx_synthesis_1;
Vyy_synthesis=Vyy_synthesis_1;
Vzz_synthesis=Vzz_synthesis_1;
Vxy_synthesis=Vxy_synthesis_1;
Vxz_synthesis=Vxz_synthesis_1;
Vyz_synthesis=Vyz_synthesis_1;
wave_reconstructed{1,:}=Vxx_synthesis;
wave_reconstructed{2,:}=Vyy_synthesis;
wave_reconstructed{3,:}=Vzz_synthesis;
wave_reconstructed{4,:}=Vxy_synthesis;
wave_reconstructed{5,:}=Vxz_synthesis;
wave_reconstructed{6,:}=Vyz_synthesis;
wave_reconstructed{7,:}=dataforreconstruction{7,:};
wave_reconstructed{8,:}=dataforreconstruction{8,:};
wave_reconstructed{9,:}=dataforreconstruction{9,:};
wave_reconstructed{10,:}=dataforreconstruction{10,:};
end

