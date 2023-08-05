clc
clear

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

%% Load the CESM data

%note that the full CESM dataset is too large to include on GitHub, so we
%upload the data from 1850 to 2100 from Miami for 100 different projections
%instead.


addpath('MiamiTempDataCESM')


P='MiamiTempDataCESM';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'Temp')
      
        c=[c,S(i)];
        
    end    
end

TMatMiami=zeros(100,251);
for p=1:100

T=load(strcat('MiamiTempDataCESM/',c(p).name)).T;
T=reshape(T,12,251)';
Tmean=mean(T,2);

TMatMiami(p,:)=Tmean;

end

TavgMiami=mean(TMatMiami,1);
 
Tdata=readtable('MiamiTempDataHistorical.csv'); %loads historical data
TdataMiami=table2array(Tdata(:,4));


%% Plot the figure

figure(1)

t=linspace(1850,2100,251);
t2=linspace(1948,2022,76);
patch([[1850,1851] fliplr([1850,1851])], [[25,26] fliplr([25,26])],[128 128 128]/256)
hold on
plot(t,(TMatMiami)','color',[128 128 128]/256,'LineWidth',0.5,'HandleVisibility','off')
alpha(0.5)
plot(t,TavgMiami,'color',[0 0 0])
xlabel('Year')
ylabel('Temperature ($^{\circ}$C)')
plot(t2,TdataMiami,'color','r')
%xlim([1908,2100])
box on
legend('CESM projections','CESM mean','Real-world data','Location','NorthWest')

set(gcf, 'Units', 'centimeters', 'Position', [0 0 20 15], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig FigureS1.pdf -pdf -r300 -Opengl 
