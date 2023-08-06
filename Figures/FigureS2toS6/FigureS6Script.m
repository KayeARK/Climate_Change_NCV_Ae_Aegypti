clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))


%rainfall values
r=linspace(0,25,1000);
c=r; %larval flushout

%temperature values
L=101;
x=linspace(0,50,L);

%carrying capacity parameters
wmax=1/25;
E=5;
I=245;
wlmax=300;
m=4.59;
wpond=(wlmax/m)*r.*wmax./(E+I+r);

%load MCMC results
a=load('MCMC/Results/a_MCMC_results.mat');
gamma=load('MCMC/Results/gamma_MCMC_results.mat');
invg=load('MCMC/Results/invg_MCMC_results.mat');
p=load('MCMC/Results/p_MCMC_results.mat');

amat=[];
invgmat=[];
gammamat=[];
pmat=[];

%for each value of parameters in the posterior, compute the fit over the
%values of temperature (0 to 50 degrees C). This gives a posterior for the
%mosquito response at each temperature.
for T=x
MParams=TempFit(T,a,gamma,invg,p);
amat=[amat MParams.a];
invgmat=[invgmat MParams.invg];
gammamat=[gammamat MParams.gamma];
pmat=[pmat MParams.p];
end

figure(1)
subplot(3,2,1)
plot(x,median(amat,1),'color',[0.9882    0.5529    0.3843])
hold on
patch([x x], [prctile(amat,2.5,1) prctile(amat,97.5,1)],[0.9882    0.5529    0.3843],'LineStyle','none')
alpha(0.3)
xlabel({'Temperature, $T$ ($^{\circ}$C)';''}) 
ylabel({'Birth rate'; '$a(T)$ (day$^{-1}$)'})
legend('Median','$95\%$ CrI','box','off','location','northwest')
ylim([0 12])
xlim([0 50])
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'A','FontSize',20,'EdgeColor','none')


subplot(3,2,2)
plot(x,median(invgmat,1),'color',[0.9882    0.5529    0.3843])
hold on
patch([x x], [prctile(invgmat,2.5,1) prctile(invgmat,97.5,1)],[0.9882    0.5529    0.3843],'LineStyle','none')
alpha(0.3)
xlabel('Temperature, $T$ ($^{\circ}$C)') 
ylabel({'Adult lifespan';'$\frac{1}{g(T)}$ (days)'})
legend('Median','$95\%$ CrI','box','off','location','northwest')
ylim([0 40])
xlim([0 50])
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'B','FontSize',20,'EdgeColor','none')



subplot(3,2,3)
ax=gca();
plot(x,median((121/96)*gammamat,1),'color',[0.9882    0.5529    0.3843])
hold on
patch([x x], [prctile((121/96)*gammamat,2.5,1) prctile((121/96)*gammamat,97.5,1)],[0.9882    0.5529    0.3843],'LineStyle','none')
alpha(0.3)
xlabel('Temperature, $T$ ($^{\circ}$C)') 
ylabel({'Aquatic-to-adult rate';'$f(T)$ (day$^{-1}$)'})
legend('Median','$95\%$ CrI','box','off','location','northwest')
ax=gca;
xlim([0 50])
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'C','FontSize',20,'EdgeColor','none')

yyaxis right
ylabel({'Egg-to-aquatic rate';'$b(T)$ (day$^{-1})$'})
ylim([0,0.2*(96/25)])

ax.YAxis(1).Color = [0 0 0];
ax.YAxis(2).Color = [0 0 0];


%division by zero is possible here, but we set that to infinity (individuals
%with a death rate of zero will live forever and vice-versa)
subplot(3,2,4)
l=(121/96).*gammamat.*((1./pmat)-1);
l(isnan(l))=inf;
l=1./l;
l(pmat==0)=0;
l(gammamat==0)=0;
plot(x,median(l,1),'color',[0.9882    0.5529    0.3843])
hold on
xlim([0 50])
patch([x x], [prctile(l,2.5,1) prctile(l,97.5,1)],[0.9882    0.5529    0.3843],'LineStyle','none')
alpha(0.3)
xlabel('Temperature, $T$ ($^{\circ}$C)') 
ylabel({'Aquatic lifespan';'$\frac{1}{d}$ (days)'})
legend('Median','$95\%$ CrI','box','off','location','northwest')
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'D','FontSize',20,'EdgeColor','none')


subplot(3,2,5)
plot([min(r),max(r)],[0.0590,0.0590],'--')
xlim([0 25])
hold on
plot(r,wpond)
xlabel('Rainfall, $R$ (mm day$^{-1}$)')
ylabel({'Carrying capacity';'$k(R)$ (m$^{-2}$)'})
legend('Silva','Our model','location','northwest','box','off')
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'E','FontSize',20,'EdgeColor','none')

subplot(3,2,6)
plot(r,c,'color',[0.9882    0.5529    0.3843])
xlabel('Rainfall, $R$ (mm day$^{-1}$)')
xlim([0 25])
ylim([0 25])
ylabel({'Larval flush out rate';'$c(R)$ (day$^{-1}$)'})
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'F','FontSize',20,'EdgeColor','none')

set(gcf, 'Units', 'centimeters', 'Position', [0 0 35 30], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig FigureS6.pdf -pdf -r300 -Opengl 


%uses the MCMC results to compute the curves (according to Briere or quadratic fits)
function MParams=TempFit(T,afun,gammafun,invgfun,pfun)

chain=afun.burntchain;
a= max(0,real(chain(1,:)*T.*(T-chain(2,:)).*sqrt(chain(3,:)-T)))';

chain=gammafun.burntchain;
gamma = max(0,real(chain(1,:)*T.*(T-chain(2,:)).*sqrt(chain(3,:)-T)))';

chain=invgfun.burntchain;
invg = max(0,-chain(1,:).*(T-chain(2,:)).*(T-chain(3,:)))'; 
    
chain=pfun.burntchain;
p = max(0,-chain(1,:).*(T-chain(2,:)).*(T-chain(3,:)))';

MParams=struct('a',a,'gamma',gamma,'invg',invg,'p',p);

end
