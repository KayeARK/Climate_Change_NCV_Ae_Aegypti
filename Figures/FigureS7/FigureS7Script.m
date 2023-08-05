clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

load('../Figure1/EcologicalNicheGeneration/Mosquitoesperm2LookupTable.mat');

MedianM(MedianM>0)=1;
MedianNiche=MedianM;

%% Kraemer paper data

K=readtable('KraemerMosquitoLocations.csv');
K_T=table2array(K(:,2));
K_R=table2array(K(:,3));

%% Liu paper data

L=readtable('LiuDengueOutbreakLocations.csv');
L_T=table2array(L(:,2));
L_R=table2array(L(:,3));

%% Extracts boundary of niche

upper=[];
lower=[];
for i=2:155  
upper(i)=find(MedianNiche(:,i),1,'last');
lower(i)=find(MedianNiche(:,i),1,'first');
end

upper=(upper-1)/10;
lower=(lower-1)/10;

ycords=[upper(2:end), 28.8,28.9,29.0,29.1,29.2,29.3,29.4,29.5,29.6,fliplr(lower(2:end)),upper(2)];
xcords=[linspace(0.1,15.4,154),15.4,15.4,15.4,15.4,15.4,15.4,15.4,15.4,15.4,fliplr(linspace(0.1,15.4,154)),0.1];


%% Plot fig S7

figure(1)

cb=brewermap(2,'Set2');
colormap(cb)
x=MedianNiche;
imAlpha=ones(size(x));
imAlpha(x==1)=0.85;
scatter(K_R,K_T,'k','filled')
hold on
scatter(L_R,L_T,'r','filled')
plot(xcords,ycords,'--','color','k')
xlim([0 20])
ylim([0 40])
set(gca,'YDir','normal')
set(gca,'FontSize',22)


xlabel('Rainfall, $R$ (mm day$^{-1}$)','FontSize',22);
ylabel('Temperature, $T$ ($^{\circ}$C)','FontSize',22);

set(gcf, 'Units', 'centimeters', 'Position', [0 0 30 20], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig FigureS7.pdf -pdf -r300 -Opengl

