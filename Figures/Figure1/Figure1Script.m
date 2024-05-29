clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))


%% Fig 1B

gamma=load('../FigureS2toS6/MCMC/Results/gamma_MCMC_results.mat');

L=101;
x=linspace(0,50,L);
gammamat=[];

for T=x
MParams=TempFit(T,gamma);
gammamat=[gammamat MParams.gamma];
end

figure(1)
plot(x,median((121/25)*gammamat,1),'color',[0.9882    0.5529    0.3843])
hold on
patch([x x], [prctile((121/25)*gammamat,2.5,1) prctile((121/25)*gammamat,97.5,1)],[0.9882    0.5529    0.3843],'LineStyle','none')
alpha(0.3)
xlabel('Temperature, $T$ ($^{\circ}$C)','FontSize',16) 
ylabel('Hatching rate, $b(T)$ (day$^{-1}$)','FontSize',16)
legend('Median','$95\%$ CrI','box','off','location','northwest','FontSize',16)
xlim([0 50])
ax=gca;
ax.XAxis.FontSize=16;
ax.YAxis.FontSize=16;

set(gcf, 'Units', 'centimeters', 'Position', [0 0 20 15], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig Figure1B.pdf -pdf -r300 -Opengl 


%% Fig 1C

load('EcologicalNicheGeneration/MLookupTable.mat');

SmallestM(SmallestM>0)=1;
BiggestM(BiggestM>0)=1;
MedianM(MedianM>0)=1;

SmallestNiche=SmallestM;
BiggestNiche=BiggestM;
MedianNiche=MedianM;


%Extracts boundary of niche

upper=[];
lower=[];
for i=2:187  
upper(i)=find(MedianNiche(:,i),1,'last');
lower(i)=find(MedianNiche(:,i),1,'first');
end

upper=(upper-1)/10;
lower=(lower-1)/10;

ycords=[upper(2:end), 28.8,28.9,29.0,29.1,29.2,29.3,29.4,29.5,29.6,fliplr(lower(2:end)),upper(2)];
xcords=[linspace(0.3,18.65,186),18.65,18.65,18.65,18.65,18.65,18.65,18.65,18.65,18.65,fliplr(linspace(0.3,18.65,186)),0.3];


figure(2)

cb=brewermap(4,'Set2');
c1=0*cb(1,:)+1*cb(2,:);
c2=0.2*cb(1,:)+0.8*cb(2,:);
c3=0.4*cb(1,:)+0.6*cb(2,:);
x=SmallestNiche;
x(x==0)=NaN;
imAlpha=ones(size(x));
imAlpha(isnan(x))=0;
imagesc(Rainfalls,Temperatures,x,'AlphaData',imAlpha);
colormap(c1)
freezeColors
hold on
x=MedianNiche-SmallestNiche;
x(x==0)=NaN;
imAlpha=ones(size(x));
imAlpha(isnan(x))=0;
imagesc(Rainfalls,Temperatures,x,'AlphaData',imAlpha);
colormap(c2)
freezeColors
x=BiggestNiche-MedianNiche;
x(x==0)=NaN;
imAlpha=ones(size(x));
imAlpha(isnan(x))=0;
imagesc(Rainfalls,Temperatures,x,'AlphaData',imAlpha);
colormap(c3)
freezeColors
x=BiggestNiche;
x(x==1)=NaN;
x(:,1:3)=0;
imAlpha=ones(size(x));
imAlpha(isnan(x))=0;
imagesc(Rainfalls,Temperatures,x,'AlphaData',imAlpha);
colormap([0.4000    0.7608    0.6471])
freezeColors
xlim([0 30])
ylim([0 40])
set(gca,'YDir','normal')
set(gca,'FontSize',22)
colormap([0.4000 0.7608 0.6471;0.4000 0.7608 0.6471;0.4000 0.7608 0.6471;c1;c2;c3])
c=colorbar('southoutside');
c.Ticks = [0.5,1+1/6,1+3/6,1+5/6] ;
c.TickLabels = ({'\newline Unsuitable for{\it Aedes aegypti}','2.5^{th}','                   50^{th} \newline Suitable for{\it Aedes aegypti}','97.5^{th}'});
c.FontSize=20;
plot(xcords,ycords,'--','color','k')

xlabel('Rainfall, $R$ (mm day$^{-1}$)','FontSize',22);
ylabel('Temperature, $T$ ($^{\circ}$C)','FontSize',22);

set(gcf, 'Units', 'centimeters', 'Position', [0 0 40 21], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig Figure1C.pdf -pdf -r300 -Opengl



%% Functions


function MParams=TempFit(T,MDRAeg)


chain=MDRAeg.burntchain;
gamma = max(0,real(chain(1,:)*T.*(T-chain(2,:)).*sqrt(chain(3,:)-T)))';


MParams=struct('gamma',gamma);

end