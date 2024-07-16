set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

London=load('SuitabilityDataLondon20902100.mat').MMedianMat;
Islamabad=load('SuitabilityDataIslamabad20902100.mat').MMedianMat;
CapeTown=load('SuitabilityDataCapeTown20902100.mat').MMedianMat;

LondonMean=mean(London,2);
LondonMax=max(London,[],2);
LondonMin=min(London,[],2);

CapeTownMean=mean(CapeTown,2);
CapeTownMax=max(CapeTown,[],2);
CapeTownMin=min(CapeTown,[],2);

IslamabadMean=mean(Islamabad,2);
IslamabadMax=max(Islamabad,[],2);
IslamabadMin=min(Islamabad,[],2);

sims=linspace(1,100,100);

figure(1)
errorbar(sims,LondonMean,LondonMean-LondonMin,LondonMax-LondonMean,'o',"MarkerFaceColor",[0.4000    0.7608    0.6471],"MarkerSize",4)
ylim([-0.5,5.5])
xlim([-5,105])
xlabel('CESM projection')
ylabel('Number of months suitable for \textit{Ae. aegypti}')
xticks([1,10,20,30,40,50,60,70,80,90,100])
text(-5,5.7,'London','FontSize',15')
set(gcf, 'Units', 'centimeters', 'Position', [0 0 25 15], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig FigureS15London.pdf -pdf -r300 -Opengl 

figure(2)
errorbar(sims,CapeTownMean,CapeTownMean-CapeTownMin,CapeTownMax-CapeTownMean,'o',"MarkerFaceColor",[0.4000    0.7608    0.6471],"MarkerSize",4)
ylim([-0.5,6.5])
xlim([-5,105])
xlabel('CESM projection')
ylabel('Number of months suitable for \textit{Ae. aegypti}')
xticks([1,10,20,30,40,50,60,70,80,90,100])
text(-5,6.7,'Cape Town','FontSize',15')
set(gcf, 'Units', 'centimeters', 'Position', [0 0 25 15], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig FigureS15CapeTown.pdf -pdf -r300 -Opengl 

figure(3)
errorbar(sims,IslamabadMean,IslamabadMean-IslamabadMin,IslamabadMax-IslamabadMean,'o',"MarkerFaceColor",[0.4000    0.7608    0.6471],"MarkerSize",4)
ylim([0.5,9.5])
xlim([-5,105])
xlabel('CESM projection')
ylabel('Number of months suitable for \textit{Ae. aegypti}')
xticks([1,10,20,30,40,50,60,70,80,90,100])
text(-5,9.8,'Islamabad','FontSize',15')
set(gcf, 'Units', 'centimeters', 'Position', [0 0 25 15], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig FigureS15Islamabad.pdf -pdf -r300 -Opengl 
