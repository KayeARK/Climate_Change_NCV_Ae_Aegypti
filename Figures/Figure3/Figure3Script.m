clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

load('../../Data/oceanshape.mat')

BestCase2100M=load('../../Data/SuitabilityDataStatistics202020602100/BestCase2100').BestCase2100;
WorstCase2100M=load('../../Data/SuitabilityDataStatistics202020602100/WorstCase2100').WorstCase2100;
AvgSim2100M=load('../../Data/SuitabilityDataAvg202020602100/MAvgClimateProjection.mat').MMedianMat;

AvgSim2100M(AvgSim2100M>0)=1;
AvgSim2100M=sum(AvgSim2100M(:,:,25:36),3);
%% 

load coastlines
lon=linspace(-180,180,288);
lat=linspace(-90,90,192);

lono=linspace(-180,180,1000);
lato=fliplr(linspace(-90,90,1000));

%% Stats

disp(['In 2100, London will have between ',num2str(BestCase2100M(144,151)),' and ', num2str(WorstCase2100M(144,151)),' months of suitability compared to ',num2str(AvgSim2100M(144,151)),' months when we use the mean of the climate projections.'])
disp(['In 2100, Cape Town will have between ',num2str(BestCase2100M(159,60)),' and ', num2str(WorstCase2100M(159,60)),' months of suitability compared to ',num2str(AvgSim2100M(159,60)),' months when we use the mean of the climate projections.'])

%% 

figure(1);

latlim=[-90,90];
lonlim=[-180,180];
axesm('robinson','MapLatLimit',latlim,'MapLonLimit',lonlim)
gridm off
mlabel off
plabel off

myColorMap=parula(256);
myColorMap(1,:)=1;
colormap(myColorMap);
surfm(lat,lon,WorstCase2100M')
framem('FEdgeColor','black','FLineWidth',1)
hidem(gca)
surfm(lato,lono,ocean)
plotm(coastlat,coastlon,'LineWidth',0.1,'Color','black')
cbr=colorbar('SouthOutside');
caxis([0,12])
set(cbr,'YTick',0:2:12)


pos = cbr.Position;
pos(4) = 0.2*pos(4);
pos(2) = pos(2)+0.15;
cbr.Position = pos;
cbr.FontSize=10;
cbr.Label.String='Most number of months suitable for{\it Ae. aegypti} in 2100 over all climate simulations';

set(gcf, 'Units', 'centimeters', 'Position', [0 0 20 20], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig('Figure3A.pdf', '-pdf', '-r300' ,'-Opengl')

%% 

figure(2);

latlim=[-90,90];
lonlim=[-180,180];
axesm('robinson','MapLatLimit',latlim,'MapLonLimit',lonlim)
gridm off
mlabel off
plabel off

colormap(myColorMap);
surfm(lat,lon,BestCase2100M')
framem('FEdgeColor','black','FLineWidth',1)
hidem(gca)
surfm(lato,lono,ocean)
plotm(coastlat,coastlon,'LineWidth',0.1,'Color','black')
cbr=colorbar('SouthOutside');
caxis([0,12])
set(cbr,'YTick',0:2:12)

pos = cbr.Position;
pos(4) = 0.2*pos(4);
pos(2) = pos(2)+0.15;
cbr.Position = pos;
cbr.FontSize=10;
cbr.Label.String='Fewest number of months suitable for{\it Ae. aegypti} in 2100 over all climate simulations';

set(gcf, 'Units', 'centimeters', 'Position', [0 0 20 20], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig('Figure3B.pdf', '-pdf', '-r300' ,'-Opengl')

