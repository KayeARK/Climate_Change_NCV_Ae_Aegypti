clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

AvgofSims2020=load('../../Data/SuitabilityDataStatistics202020602100/AvgofSims').Avg2020;

load('../../Data/oceanshape.mat')

data=readtable('aegypti.csv');

x=table2array(data(:,7));
y=table2array(data(:,6));


%% 

load coastlines
lon=linspace(-180,180,288);
lat=linspace(-90,90,192);

lono=linspace(-180,180,1000);
lato=fliplr(linspace(-90,90,1000));

MMedianYearly2020AvgofSims=AvgofSims2020;



%% 

myColorMap=parula(256);
myColorMap(1,:)=1;

figure(1);

latlim=[-90,90];
lonlim=[-180,180];
axesm('robinson','MapLatLimit',latlim,'MapLonLimit',lonlim)
gridm off
mlabel off
plabel off

colormap(myColorMap);
surfm(lat,lon,MMedianYearly2020AvgofSims')
framem('FEdgeColor','black','FLineWidth',1)
hidem(gca)
surfm(lato,lono,ocean)
plotm(coastlat,coastlon,'LineWidth',1,'Color','black')
scatterm(y,x,0.5,'k','filled')
cbr=colorbar('SouthOutside');
caxis([0,12])
set(cbr,'YTick',0:2:12)

pos = cbr.Position;
pos(4) = 0.3*pos(4);
pos(2) = pos(2)+0;
cbr.Position = pos;
cbr.FontSize=(5/2)*8;
cbr.Label.String='Number of months suitable for{\it Ae. aegypti} in 2020';

set(gcf, 'Units', 'centimeters', 'Position', [0 0 50 50], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig('FigureS8.pdf', '-pdf', '-r300' ,'-Opengl')

