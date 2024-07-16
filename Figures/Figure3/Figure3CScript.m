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

Var2100M=load('../../Data/SuitabilityDataStatistics202020602100/VarianceMat').Var2100;
BestCase2100M=load('../../Data/SuitabilityDataStatistics202020602100/BestCase2100').BestCase2100;
WorstCase2100M=load('../../Data/SuitabilityDataStatistics202020602100/WorstCase2100').WorstCase2100;

Var2060M=load('../../Data/SuitabilityDataStatistics202020602100/VarianceMat').Var2060;
BestCase2060M=load('../../Data/SuitabilityDataStatistics202020602100/BestCase2100').BestCase2060;
WorstCase2060M=load('../../Data/SuitabilityDataStatistics202020602100/WorstCase2100').WorstCase2060;

%% 

load coastlines
lon=linspace(-180,180,288);
lat=linspace(-90,90,192);

lono=linspace(-180,180,1000);
lato=fliplr(linspace(-90,90,1000));

myColorMap=parula(256);
myColorMap(1,:)=1;
colormap(myColorMap);
%% 

figure(1);

latlim=[-90,90];
lonlim=[-180,180];
axesm('robinson','MapLatLimit',latlim,'MapLonLimit',lonlim)
gridm off
mlabel off
plabel off

colormap(myColorMap);
surfm(lat,lon,(WorstCase2100M-BestCase2100M)')
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
cbr.Label.String='Difference in months between the most and least suitable climate projection';
set(gcf, 'Units', 'centimeters', 'Position', [0 0 20 20], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig('Figure3C.pdf', '-pdf', '-r300' ,'-Opengl')



