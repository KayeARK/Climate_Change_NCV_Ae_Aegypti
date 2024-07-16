
set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

London=load('SuitabilityDataLondon.mat').MMedianMat;
Islamabad=load('SuitabilityDataIslamabad.mat').MMedianMat;
CapeTown=load('SuitabilityDataCapeTown.mat').MMedianMat;


figure(1)

t=tiledlayout(3,1);
nexttile
histogram(London(:,1),[0,1,2,3,4]-0.5,'EdgeColor','none','FaceColor',[0.4000    0.7608    0.6471])
text(mean(London(:,1)),55,num2str(mean(London(:,1))),'HorizontalAlignment','center')
hold on
plot([mean(London(:,1)),mean(London(:,1))],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(London(:,2)+12,[0,1,2,3,4]+12-0.5,'EdgeColor','none','FaceColor',[0.9882    0.5529    0.3843])
text(mean(London(:,2))+12*1,55,num2str(mean(London(:,2))),'HorizontalAlignment','center')
hold on
plot([mean(London(:,2))+12*1,mean(London(:,2))+12*1],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(London(:,3)+2*12,[0,1,2,3,4,5]+2*12-0.5,'EdgeColor','none','FaceColor',[0.5529    0.6275    0.7961])
text(mean(London(:,3))+12*2,55,num2str(mean(London(:,3))),'HorizontalAlignment','center')
hold on
plot([mean(London(:,3))+12*2,mean(London(:,3))+12*2],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(London(:,4)+3*12,[0,1,2,3,4,5]+3*12-0.5,'EdgeColor','none','FaceColor',[0.9059    0.5412    0.7647])
text(mean(London(:,4))+12*3,55,num2str(mean(London(:,4))),'HorizontalAlignment','center')
hold on
plot([mean(London(:,4))+12*3,mean(London(:,4))+12*3],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(London(:,5)+4*12,[0,1,2,3,4]+4*12-0.5,'EdgeColor','none','FaceColor',[0.6510    0.8471    0.3294])
text(mean(London(:,5))+12*4,55,num2str(mean(London(:,5))),'HorizontalAlignment','center')
hold on
plot([mean(London(:,5))+12*4,mean(London(:,5))+12*4],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(London(:,6)+5*12,[0,1,2,3,4,5]+5*12-0.5,'EdgeColor','none','FaceColor',[1.0000    0.8510    0.1843])
text(mean(London(:,6))+12*5,55,num2str(mean(London(:,6))),'HorizontalAlignment','center')
hold on
plot([mean(London(:,6))+12*5,mean(London(:,6))+12*5],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(London(:,7)+6*12,[0,1,2,3,4,5]+6*12-0.5,'EdgeColor','none','FaceColor',[0.8980    0.7686    0.5804])
text(mean(London(:,7))+12*6,55,num2str(mean(London(:,7))),'HorizontalAlignment','center')
hold on
plot([mean(London(:,7))+12*6,mean(London(:,7))+12*6],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(London(:,8)+7*12,[0,1,2,3,4,5]+7*12-0.5,'EdgeColor','none','FaceColor',[0.7020    0.7020    0.7020])
text(mean(London(:,8))+12*7,55,num2str(mean(London(:,8))),'HorizontalAlignment','center')
hold on
plot([mean(London(:,8))+12*7,mean(London(:,8))+12*7],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(London(:,9)+8*12,[0,1,2,3,4,5,6]+8*12-0.5,'EdgeColor','none','FaceColor',[0.4000    0.7608    0.6471])
text(mean(London(:,9))+12*8,55,num2str(mean(London(:,9))),'HorizontalAlignment','center')
hold on
plot([mean(London(:,9))+12*8,mean(London(:,9))+12*8],[0,53],'k','Linewidth',0.5,'Linestyle','--')
xlim([-2,8*12+11])
xticks([0,3,12,15,24,28,36,40,48,51,60,64,72,76,84,88,96,101])
xticklabels({'0','3','0','3','0','4','0','4','0','3','0','3','0','4','0','4','0','5'})
ylim([0,60])
set(gca,'TickDir','out')
ax=gca;
ax.Box='off';
xline(ax.XLim(2),'-k','linewidth',ax.LineWidth)
yline(ax.YLim(2),'-k','linewidth',ax.LineWidth)
ylabel({'Frequency'},'FontSize',15)
text(-20,69,'London','FontSize',15')

nexttile
histogram(CapeTown(:,1),[0,1,2,3,4]-0.5,'EdgeColor','none','FaceColor',[0.4000    0.7608    0.6471])
hold on
text(mean(CapeTown(:,1)),55,num2str(mean(CapeTown(:,1))),'HorizontalAlignment','center')
hold on
plot([mean(CapeTown(:,1)),mean(CapeTown(:,1))],[0,53],'k','Linewidth',0.5,'Linestyle','--')
histogram(CapeTown(:,2)+12,[0,1,2,3,4,5]+12-0.5,'EdgeColor','none','FaceColor',[0.9882    0.5529    0.3843])
hold on
text(mean(CapeTown(:,2))+12*1,55,num2str(mean(CapeTown(:,2))),'HorizontalAlignment','center')
hold on
plot([mean(CapeTown(:,2))+12*1,mean(CapeTown(:,2))+12*1],[0,53],'k','Linewidth',0.5,'Linestyle','--')
histogram(CapeTown(:,3)+2*12,[0,1,2,3,4,5]+2*12-0.5,'EdgeColor','none','FaceColor',[0.5529    0.6275    0.7961])
hold on
text(mean(CapeTown(:,3))+12*2,55,num2str(mean(CapeTown(:,3))),'HorizontalAlignment','center')
hold on
plot([mean(CapeTown(:,3))+12*2,mean(CapeTown(:,3))+12*2],[0,53],'k','Linewidth',0.5,'Linestyle','--')
histogram(CapeTown(:,4)+3*12,[0,1,2,3,4]+3*12-0.5,'EdgeColor','none','FaceColor',[0.9059    0.5412    0.7647])
hold on
text(mean(CapeTown(:,4))+12*3,55,num2str(mean(CapeTown(:,4))),'HorizontalAlignment','center')
hold on
plot([mean(CapeTown(:,4))+12*3,mean(CapeTown(:,4))+12*3],[0,53],'k','Linewidth',0.5,'Linestyle','--')
histogram(CapeTown(:,5)+4*12,[0,1,2,3,4]+4*12-0.5,'EdgeColor','none','FaceColor',[0.6510    0.8471    0.3294])
hold on
text(mean(CapeTown(:,5))+12*4,55,num2str(mean(CapeTown(:,5))),'HorizontalAlignment','center')
hold on
plot([mean(CapeTown(:,5))+12*4,mean(CapeTown(:,5))+12*4],[0,53],'k','Linewidth',0.5,'Linestyle','--')
histogram(CapeTown(:,6)+5*12,[0,1,2,3,4,5]+5*12-0.5,'EdgeColor','none','FaceColor',[1.0000    0.8510    0.1843])
text(mean(CapeTown(:,6))+12*5,55,num2str(mean(CapeTown(:,6))),'HorizontalAlignment','center')
hold on
plot([mean(CapeTown(:,6))+12*5,mean(CapeTown(:,6))+12*5],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(CapeTown(:,7)+6*12,[0,1,2,3,4,5,6]+6*12-0.5,'EdgeColor','none','FaceColor',[0.8980    0.7686    0.5804])
hold on
text(mean(CapeTown(:,7))+12*6,55,num2str(mean(CapeTown(:,7))),'HorizontalAlignment','center')
hold on
plot([mean(CapeTown(:,7))+12*6,mean(CapeTown(:,6))+12*6],[0,53],'k','Linewidth',0.5,'Linestyle','--')
histogram(CapeTown(:,8)+7*12,[0,1,2,3,4,5,6]+7*12-0.5,'EdgeColor','none','FaceColor',[0.7020    0.7020    0.7020])
hold on
text(mean(CapeTown(:,8))+12*7,55,num2str(mean(CapeTown(:,8))),'HorizontalAlignment','center')
hold on
plot([mean(CapeTown(:,8))+12*7,mean(CapeTown(:,8))+12*7],[0,53],'k','Linewidth',0.5,'Linestyle','--')
histogram(CapeTown(:,9)+8*12,[0,1,2,3,4,5]+8*12-0.5,'EdgeColor','none','FaceColor',[0.4000    0.7608    0.6471])
text(mean(CapeTown(:,9))+12*8,55,num2str(mean(CapeTown(:,9))),'HorizontalAlignment','center')
hold on
plot([mean(CapeTown(:,9))+12*8,mean(CapeTown(:,9))+12*8],[0,53],'k','Linewidth',0.5,'Linestyle','--')
xlim([-2,8*12+11])
set(gca,'TickDir','out')
ylim([0,60])
xticks([0,3,12,16,24,28,36,39,48,51,60,64,72,77,84,89,96,100])
xticklabels({'0','3','0','4','0','4','0','3','0','3','0','4','0','5','0','5','0','4'})
ax=gca;
ax.Box='off';
xline(ax.XLim(2),'-k','linewidth',ax.LineWidth)
yline(ax.YLim(2),'-k','linewidth',ax.LineWidth)
ylabel({'Frequency'},'FontSize',15)
yline(ax.YLim(2),'-k','linewidth',ax.LineWidth)
text(-20,69,'Cape Town','FontSize',15')

nexttile
histogram(Islamabad(:,1),[2,3,4,5,6,7,8]-0.5,'EdgeColor','none','FaceColor',[0.4000    0.7608    0.6471])
text(mean(Islamabad(:,1)),55,num2str(mean(Islamabad(:,1))),'HorizontalAlignment','center')
hold on
plot([mean(Islamabad(:,1)),mean(Islamabad(:,1))],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(Islamabad(:,2)+12,[1,2,3,4,5,6,7,8]+12-0.5,'EdgeColor','none','FaceColor',[0.9882    0.5529    0.3843])
text(mean(Islamabad(:,2))+1*12,55,num2str(mean(Islamabad(:,2))),'HorizontalAlignment','center')
hold on
plot([mean(Islamabad(:,2))+1*12,mean(Islamabad(:,2))+1*12],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(Islamabad(:,3)+2*12,[1,2,3,4,5,6,7]+2*12-0.5,'EdgeColor','none','FaceColor',[0.5529    0.6275    0.7961])
text(mean(Islamabad(:,3))+2*12,55,num2str(mean(Islamabad(:,3))),'HorizontalAlignment','center')
hold on
plot([mean(Islamabad(:,3))+2*12,mean(Islamabad(:,3))+2*12],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(Islamabad(:,4)+3*12,[0,1,2,3,4,5,6,7,8]+3*12-0.5,'EdgeColor','none','FaceColor',[0.9059    0.5412    0.7647])
text(mean(Islamabad(:,4))+3*12,55,num2str(mean(Islamabad(:,4))),'HorizontalAlignment','center')
hold on
plot([mean(Islamabad(:,4))+3*12,mean(Islamabad(:,4))+3*12],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(Islamabad(:,5)+4*12,[2,3,4,5,6,7,8]+4*12-0.5,'EdgeColor','none','FaceColor',[0.6510    0.8471    0.3294])
text(mean(Islamabad(:,5))+4*12,55,num2str(mean(Islamabad(:,5))),'HorizontalAlignment','center')
hold on
plot([mean(Islamabad(:,5))+4*12,mean(Islamabad(:,5))+4*12],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(Islamabad(:,6)+5*12,[2,3,4,5,6,7,8]+5*12-0.5,'EdgeColor','none','FaceColor',[1.0000    0.8510    0.1843])
text(mean(Islamabad(:,6))+5*12,55,num2str(mean(Islamabad(:,6))),'HorizontalAlignment','center')
hold on
plot([mean(Islamabad(:,6))+5*12,mean(Islamabad(:,6))+5*12],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(Islamabad(:,7)+6*12,[1,2,3,4,5,6,7,8,9]+6*12-0.5,'EdgeColor','none','FaceColor',[0.8980    0.7686    0.5804])
text(mean(Islamabad(:,7))+6*12,55,num2str(mean(Islamabad(:,7))),'HorizontalAlignment','center')
hold on
plot([mean(Islamabad(:,7))+6*12,mean(Islamabad(:,7))+6*12],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(Islamabad(:,8)+7*12,[2,3,4,5,6,7]+7*12-0.5,'EdgeColor','none','FaceColor',[0.7020    0.7020    0.7020])
text(mean(Islamabad(:,8))+7*12,55,num2str(mean(Islamabad(:,8))),'HorizontalAlignment','center')
hold on
plot([mean(Islamabad(:,8))+7*12,mean(Islamabad(:,8))+7*12],[0,53],'k','Linewidth',0.5,'Linestyle','--')
hold on
histogram(Islamabad(:,9)+8*12,[2,3,4,5,6,7,8]+8*12-0.5,'EdgeColor','none','FaceColor',[0.4000    0.7608    0.6471])
text(mean(Islamabad(:,9))+8*12,55,num2str(mean(Islamabad(:,9))),'HorizontalAlignment','center')
hold on
plot([mean(Islamabad(:,9))+8*12,mean(Islamabad(:,9))+8*12],[0,53],'k','Linewidth',0.5,'Linestyle','--')
xlim([-2,8*12+11])
ylim([0,60])
set(gca,'TickDir','out')
xticks([2,7,13,19,25,30,36,43,50,55,62,67,73,80,86,90,98,103])
xticklabels({'2','7','1','7','1','6','0','7','2','7','2','7','1','8','2','6','2','7'})
ax=gca;
ax.Box='off';
xline(ax.XLim(2),'-k','linewidth',ax.LineWidth)
yline(ax.YLim(2),'-k','linewidth',ax.LineWidth)
ylabel({'Frequency'},'FontSize',15)
t.TileSpacing='tight';
text(-20,69,'Islamabad','FontSize',15')
text(4.5,-22,'2020','HorizontalAlignment','center','FontSize',15,'Color',[0.4000    0.7608    0.6471])
text(16,-22,'2030','HorizontalAlignment','center','FontSize',15,'Color',[0.9882    0.5529    0.3843])
text(27.5,-22,'2040','HorizontalAlignment','center','FontSize',15,'Color',[0.5529    0.6275    0.7961])
text(39.5,-22,'2050','HorizontalAlignment','center','FontSize',15,'Color',[0.9059    0.5412    0.7647])
text(52.5,-22,'2060','HorizontalAlignment','center','FontSize',15,'Color',[0.6510    0.8471    0.3294])
text(64.5,-22,'2070','HorizontalAlignment','center','FontSize',15,'Color',[1.0000    0.8510    0.1843])
text(76.5,-22,'2080','HorizontalAlignment','center','FontSize',15,'Color',[0.8980    0.7686    0.5804])
text(88,-22,'2090','HorizontalAlignment','center','FontSize',15,'Color',[0.7020    0.7020    0.7020])
text(100.5,-22,'2100','HorizontalAlignment','center','FontSize',15,'Color',[0.4000    0.7608    0.6471])

set(gcf, 'Units', 'centimeters', 'Position', [0 0 25 15], 'PaperUnits', 'centimeters', 'PaperSize', [15 25]);
export_fig FigureS15.pdf -pdf -r300 -Opengl 
