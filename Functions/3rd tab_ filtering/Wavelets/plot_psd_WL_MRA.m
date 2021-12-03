function [ w ] = plot_psd_WL_MRA( GG_WL,data_for_filtering)
%   GeoGravGOCE project
%   E. Pitenis (f_normalized_psd function by D. Piretzidis)
%   GravLab, AUTh, 20/8/2020
%   ----------------------------------------------------------------------------------------
%   INFO
%   Function for plotting the psds of the reconstructed signal after WL-MRA
%   ----------------------------------------------------------------------------------------
%% Load data
name_current_day=GG_WL{5,:};

%% Computation of psds
% Creation of folder
p = 1;
foldername = sprintf('Wavelets/WL MRA Reconstruction/PSDs after WL MRA%02',p);
mkdir(foldername)

T_s=1; %sampling period (for GOCE the sampling period is 1 sec)
counter_fig_close=1;
for i=1:length(GG_WL{1,:})
    
    f = figure('visible','off');
    subplot(2,3,1)
    [freq2, spectrum2]=f_normalized_psd(cell2mat(data_for_filtering{1,:}(i,1)), T_s);
    hold all
    [freq, spectrum]=f_normalized_psd(cell2mat(GG_WL{6,:}(i,1)), T_s);
    % MBW limits
    x1=[0.005 0.005];
    x2=[0.1 0.1];
    y1=[10^(-8) 10^(6)];
    plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
    hold on
    plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
    hold off;
    
    % Arrow with two head at both end and text between
    y = [0.61 0.61];
    x = [0.285 0.3];     % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
    annotation('textarrow',x,y,'String','         MBW','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
    x = [0.2630 0.248];
    annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
    %hold off;
    set(gca,'YScale','log','XScale','log');
    grid on;
    %axis labels
    xlabel('Frequency (Hz) ','fontsize',14)
    ylabel('Power','fontsize',14)
    axis([10^(-5),10^(0),10^(-8),10^(2)]);
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    name=name_current_day{i,1}(i);
    DateString = datestr( name );
    title({['\bf\fontsize{16}PSD Vxx Synthesis  ',num2str(DateString)]})
    legend('PSD Unfiltered ','PSD Vxx Synthesis ');
    
    subplot(2,3,2)
    [freq2, spectrum2]=f_normalized_psd(cell2mat(data_for_filtering{2,:}(i,1)), T_s);
    hold all
    [freq, spectrum]=f_normalized_psd(cell2mat(GG_WL{7,:}(i,1)), T_s);
    % MBW limits
    x1=[0.005 0.005];
    x2=[0.1 0.1];
    y1=[10^(-8) 10^(6)];
    plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
    hold on
    plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
    hold off;
    
    
    % Arrow with two head at both end and text between
    y = [0.61 0.61];
    x = [0.5650 0.58];    % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
    annotation('textarrow',x,y,'String','         MBW','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
    x = [0.5430 0.528];
    annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
    hold off;
    set(gca,'YScale','log','XScale','log');
    grid on;
    %axis labels
    xlabel('Frequency (Hz) ','fontsize',14)
    ylabel('Power','fontsize',14)
    axis([10^(-5),10^(0),10^(-8),10^(2)]);
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    name=name_current_day{i,1}(i);
    DateString = datestr( name );
    title({['\bf\fontsize{16}PSD Vyy Synthesis  ',num2str(DateString)] })
    legend('PSD Unfiltered ','PSD Vyy Synthesis ');
    
    
    subplot(2,3,3)
    [freq2, spectrum2]=f_normalized_psd(cell2mat(data_for_filtering{3,:}(i,1)), T_s);
    hold all
    [freq, spectrum]=f_normalized_psd(cell2mat(GG_WL{8,:}(i,1)), T_s);
    % MBW limits
    x1=[0.005 0.005];
    x2=[0.1 0.1];
    y1=[10^(-8) 10^(6)];
    plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
    hold on
    plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
    hold off;
    
    
    % Arrow with two head at both end and text between
    y = [0.61 0.61];
    x = [0.845 0.86];       % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
    annotation('textarrow',x,y,'String','         MBW','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
    x = [0.823 0.8080];
    annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
    hold off;
    set(gca,'YScale','log','XScale','log');
    grid on;
    %axis labels
    xlabel('Frequency (Hz) ','fontsize',14)
    ylabel('Power','fontsize',14)
    axis([10^(-5),10^(0),10^(-8),10^(2)]);
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    name=name_current_day{i,1}(i);
    DateString = datestr( name );
    title({['\bf\fontsize{16}PSD Vzz Synthesis  ',num2str(DateString)]})
    legend('PSD Unfiltered ','PSD Vzz Synthesis ');
    
    subplot(2,3,4)
    [freq2, spectrum2]=f_normalized_psd(cell2mat(data_for_filtering{4,:}(i,1)), T_s);
    hold all
    [freq, spectrum]=f_normalized_psd(cell2mat(GG_WL{9,:}(i,1)), T_s);
    % MBW limits
    x1=[0.005 0.005];
    x2=[0.1 0.1];
    y1=[10^(-8) 10^(6)];
    plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
    hold on
    plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
    hold off;
    
    
    % Arrow with two head at both end and text between
    y = [0.132 0.132];
    x = [0.285 0.3];     % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
    annotation('textarrow',x,y,'String','         MBW','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
    x = [0.2630 0.248];
    annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
    hold off;
    set(gca,'YScale','log','XScale','log');
    grid on;
    %axis labels
    xlabel('Frequency (Hz) ','fontsize',14)
    ylabel('Power','fontsize',14)
    axis([10^(-5),10^(0),10^(-8),10^(2)]);
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    name=name_current_day{i,1}(i);
    DateString = datestr( name );
    title({['\bf\fontsize{16}PSD Vxy Synthesis  ',num2str(DateString)]})
    legend('PSD Unfiltered ','PSD Vxy Synthesis ');
    
    subplot(2,3,5)
    [freq2, spectrum2]=f_normalized_psd(cell2mat(data_for_filtering{5,:}(i,1)), T_s);
    hold all
    [freq, spectrum]=f_normalized_psd(cell2mat(GG_WL{10,:}(i,1)), T_s);
    % MBW limits
    x1=[0.005 0.005];
    x2=[0.1 0.1];
    y1=[10^(-8) 10^(6)];
    plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
    hold on
    plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
    hold off;
    
    
    % Arrow with two head at both end and text between
    y = [0.132 0.132];
    x = [0.5650 0.58];     % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
    annotation('textarrow',x,y,'String','         MBW','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
    x = [0.5430 0.528];
    annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
    hold off;
    set(gca,'YScale','log','XScale','log');
    grid on;
    %axis labels
    xlabel('Frequency (Hz) ','fontsize',14)
    ylabel('Power','fontsize',14)
    axis([10^(-5),10^(0),10^(-8),10^(2)]);
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    name=name_current_day{i,1}(i);
    DateString = datestr( name );
    title({['\bf\fontsize{16}PSD Vxz Synthesis  ',num2str(DateString)] })
    legend('PSD Unfiltered ','PSD Vxz Synthesis ');
    
    subplot(2,3,6)
    [freq2, spectrum2]=f_normalized_psd(cell2mat(data_for_filtering{6,:}(i,1)), T_s);
    hold all
    [freq, spectrum]=f_normalized_psd(cell2mat(GG_WL{11,:}(i,1)), T_s);
    % MBW limits
    x1=[0.005 0.005];
    x2=[0.1 0.1];
    y1=[10^(-8) 10^(6)];
    plot(x1,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
    hold on
    plot(x2,y1, 'LineStyle', '--','LineWidth',2,'Color',[0 0 0])
    hold off;
    
    
    % Arrow with two head at both end and text between
    y = [0.132 0.132];
    x = [0.845 0.86];     % adjust location of left arrow starting point (the sum of this with 'x' should not be negative)
    annotation('textarrow',x,y,'String','         MBW','FontWeight','bold','FontSize' ,10,'FontSize',10,'Linewidth',1)
    x = [0.823 0.8080];
    annotation('textarrow',x,y,'FontSize',13,'Linewidth',2)
    hold off;
    set(gca,'YScale','log','XScale','log');
    grid on;
    %axis labels
    xlabel('Frequency (Hz) ','fontsize',14)
    ylabel('Power','fontsize',14)
    axis([10^(-5),10^(0),10^(-8),10^(2)]);
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    title({['\bf\fontsize{16}PSD Vyz Synthesis  ',num2str(DateString)]})
    legend('PSD Unfiltered ','PSD Vyz Synthesis ');
    
    %g=i;
    % save figures
    set(gcf, 'Position', get(0,'Screensize'),'PaperPositionMode','auto');
    filename_save = sprintf('PSD_GG_Synthesis_%s.jpeg',num2str(DateString));
    % print(filename_save,'-djpeg','-r300')
    txtname = fullfile(foldername,filename_save);
    print(f, txtname,'-djpeg','-r300');
    
    % save .fig
    set(gcf, 'CreateFcn', 'set(gcbo,''Visible'',''on'')');
    filename_save = sprintf('PSD_GG_Synthesis_%s.fig',num2str(DateString));
    txtname = fullfile(foldername,filename_save);
    savefig(txtname);
    
    counter_fig_close=counter_fig_close+1;
    
    
    if counter_fig_close>5
        counter_fig_close=1;
        close all
    end
    
end

w=1;
% message for the user/ all ok/ check the folder "PSDs after WL MRA"
% for the results.
Opt.Interpreter = 'tex';
Opt.WindowStyle = 'normal';
msgbox({'Your figures (.jpeg) and (.fig) were saved in the new folder "WL MRA Reconstruction/PSDs after WL MRA " .';'';' Check them!'}, 'Info', 'help', Opt);

end
