clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

AvgofSims2020=load('SuitabilityDataStatistics202020602100/AvgofSims').Avg2020;
AvgofSims2060=load('SuitabilityDataStatistics202020602100/AvgofSims').Avg2060;
AvgofSims2100=load('SuitabilityDataStatistics202020602100/AvgofSims').Avg2100;
AvgofSims2050=load('SuitabilityDataStatistics202020602100/AvgofSims').Avg2050;


load('../../../Data/oceanshape.mat')

%% 

load coastlines
lon=linspace(-180,180,288);
lat=linspace(-90,90,192);

lono=linspace(-180,180,1000);
lato=fliplr(linspace(-90,90,1000));

MMedianYearly2020AvgofSims=AvgofSims2020;
MMedianYearly2060AvgofSims=AvgofSims2060;
MMedianYearly2100AvgofSims=AvgofSims2100;
MMedianYearly2050AvgofSims=AvgofSims2050;


%% 
myColorMap=[121/256,159/256,203/256;1,1,1;249/256,102/256,94/256]; %original

figure(1);

latlim=[-90,90];
lonlim=[-180,180];
axesm('robinson','MapLatLimit',latlim,'MapLonLimit',lonlim)
gridm off
mlabel off
plabel off

ecmap=MMedianYearly2100AvgofSims-MMedianYearly2020AvgofSims;
up=1;
ecmap(ecmap>up)=1;
ecmap(ecmap<-up)=-1;
ecmap(ecmap<up & ecmap>-up)=0;


colormap(myColorMap);
surfm(lat,lon,ecmap')
framem('FEdgeColor','black','FLineWidth',1)
hidem(gca)
surfm(lato,lono,ocean)
plotm(coastlat,coastlon,'LineWidth',0.1,'Color','black')
cbr=colorbar('SouthOutside');
caxis([-1,1])
set(cbr,'YTick',-2/3:2/3:2/3)
set(cbr,'YTickLabel',{'Contraction','Stability','Expansion'})

pos = cbr.Position;
pos(4) = 0.2*pos(4);
pos(2) = pos(2)+0.15;
cbr.Position = pos;
cbr.FontSize=10;
cbr.Label.String='Change in{\it Ae. aegypti} suitability in different locations';

set(gcf, 'Units', 'centimeters', 'Position', [0 0 20 20], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig('Figure2RyanAeaegypti.pdf', '-pdf', '-r300' ,'-Opengl')

