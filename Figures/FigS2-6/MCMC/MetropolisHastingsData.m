set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))



%DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T=readtable('aegyptiDENVmodelTempData_2016-03-30.csv');

x=T.trait_name;
temps=T.T;
traits=T.trait;
yprime=T.ref;

y=strings(1,length(x));
for i=1:length(x)
      y(i)=num2str(cell2mat(x(i)));
end


bT=[];
b=[];

for i=1:length(x)
    if  y(i)=='b'&& (yprime(i)=="Carrington_et_al_2013_PNTD" || yprime(i)=="Alto&Bettinardi_2013_AJTMH" || yprime(i)=="Watts_et_al_1987_AJTMH")
        bT=[bT temps(i)];
        b=[b traits(i)];
    end
end


scatter(bT,b)
%% 



ydata=b;
xdata=bT;

% figure(1)
% scatter(xdata,ydata,'filled')
% xlabel('Temperature')
% ylabel('a')
% set(gcf, 'Units', 'centimeters', 'Position', [0 0 20 15], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
% saveas(gcf, 'ProcessedFecundityData.pdf')
% 
% export_fig ProcessedFecundityData.pdf -pdf -r300 -painters -transparent


%MCMC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%rng(1)

x=xdata;
y=ydata;

b=ydata;
bT=xdata;

iterations=100000;
burnin=50000;


M=5;
posteriormean=[];
posteriorvar=[];
for i=1:M
    startvalue=[10e-5 + (10e-3-10e-5)*rand(1), 0+(20)*rand(1),25+(45-25)*rand(1),0+(1)*rand(1)];
    startvalue=[0.0006,16,40,0.2];
    [burntchain,acceptance]=MH(x,y,iterations,burnin,startvalue);
    posteriormean(:,i)=mean(burntchain,2);
    posteriorvar(:,i)=var(burntchain,0,2);
    chains{i}=burntchain;
end
totmean=mean(posteriormean,2);

B=(iterations/(M-1))*(sum((posteriormean-totmean).^2,2));
W=mean(posteriorvar,2);

Vtilde=(((iterations-1)/iterations)*W)+(((M+1)/(iterations*M))*B);

R=sqrt(Vtilde./W);

%% 


testx=linspace(0,max(bT)+10,1000);
cmean=mean(burntchain(1,:));
T0mean=mean(burntchain(2,:));
Tmmean=mean(burntchain(3,:));
testy=cmean.*testx.*(testx-T0mean).*sqrt(Tmmean-testx);
testy=max(0,real(testy));


figure(2)
subplot(3,4,1)
histogram(burntchain(1,:),'Normalization','pdf')
hold on
supp=linspace(min(burntchain(1,:)),max(burntchain(1,:)),1000);
range=gampdf(supp,7,0.001);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(1,:)),max(burntchain(1,:))])
xlabel("$c$")
ylabel("Probability Density")
subplot(3,4,2)
histogram(burntchain(2,:),'Normalization','pdf')
hold on
supp=linspace(min(burntchain(2,:)),max(burntchain(2,:)),1000);
range=gampdf(supp,7,2);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(2,:)),max(burntchain(2,:))])
xlabel("$T_{0}$")
subplot(3,4,3)
histogram(burntchain(3,:),'Normalization','pdf')
hold on
supp=linspace(min(burntchain(3,:)),max(burntchain(3,:)),1000);
range=gampdf(supp,10,4);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(3,:)),max(burntchain(3,:))])
xlabel("$T_{m}$")
subplot(3,4,4)
histogram(burntchain(4,:),'Normalization','pdf')
hold on
supp=linspace(min(burntchain(4,:)),max(burntchain(4,:)),1000);
range=unifpdf(supp,0,5);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(4,:)),max(burntchain(4,:))])
xlabel("$\sigma^{2}$")
subplot(3,4,5)
plot(burntchain(1,:))
ylabel("$c$")
xlabel("Iterations")
xlim([0 iterations-burnin])
subplot(3,4,6)
plot(burntchain(2,:))
ylabel("$T_{0}$")
xlabel("Iterations")
xlim([0 iterations-burnin])
subplot(3,4,7)
plot(burntchain(3,:))
ylabel("$T_{m}$")
xlabel("Iterations")
xlim([0 iterations-burnin])
subplot(3,4,8)
plot(burntchain(4,:))
ylabel("$\sigma^{2}$")
xlabel("Iterations")
xlim([0 iterations-burnin])
sgtitle("Acceptance Rate is " + acceptance)

%% 

% set(gcf, 'Units', 'centimeters', 'Position', [0 0 35 17], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
% saveas(gcf, 'aTracePlot.pdf')
% set(get(gca, 'Title'), 'Visible', 'on')
% export_fig aTracePlot.pdf -pdf -r300 -painters -transparent


% figure(3)
% plot(testx,testy)
% hold on
% scatter(pEAT,pEA,'filled')
% xlabel("Temperature")
% ylabel("a")

% set(gcf, 'Units', 'centimeters', 'Position', [0 0 20 15], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
% saveas(gcf, 'FittedData.pdf')
% 
% export_fig FittedData.pdf -pdf -r300 -painters -transparent


% [pEAT,sortIdx] = sort(pEAT,'ascend');
% pEA = pEA(sortIdx);


% temppEA=[];
% a=[];
% aT=[];
% 
% for i=1:length(x)
%     if y(i)=='GCR'
%         aT=[aT temps(i)];
%         a=[a traits(i)];
%     end
% end
% count=0;
% for i=unique(pEAT)
% 
%    count=count+1;
%    temp1=(pEAT==i);
%    temp2=pEA.*temp1;
%    
%    if sum(temp2)>0       
%        temppEA(count)=mean(nonzeros(temp2));
%    else
%        temppEA(count)=0;
%    end    
%     
% end
% 
% pEA=temppEA;
% pEAT=unique(pEAT);
% 
% figure(4)
% plot(testx,testy)
% hold on
% scatter(pEAT,pEA,'filled')
% xlabel("Temperature")
% ylabel("a")

% set(gcf, 'Units', 'centimeters', 'Position', [0 0 20 15], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
% saveas(gcf, 'FittedProcData.pdf')
% 
% export_fig FittedProcData.pdf -pdf -r300 -painters -transparent
%% 


save('Parameter Fits/bParasAegypti.mat','burntchain','acceptance','R')


% %This likelihood is for Briere
function likelihood=likelihood(c,T0,Tm,sd,x,y)

pred=max(0,real(c.*x.*(x-T0).*sqrt(Tm-x)));
likelihood=sum(log(normpdf(y,pred,sd)));

end


%This likelihood is for Quadratic
% function likelihood=likelihood(c,T0,Tm,sd,x,y)
% 
% pred=max(0,-c.*(x-T0).*(x-Tm));
% likelihood=sum(log(normpdf(y,pred,sd)));
% 
% end


function prior=prior(c,T0,Tm,sd)

T=linspace(0,50,1000);
brier=max(0,real(c.*T.*(T-T0).*sqrt(Tm-T)));
maxb=max(brier);

if maxb>1
    prior=log(0);
else
prior=log(gampdf(c,6,1e-4))+log(gampdf(T0,8,2))+log(unifpdf(Tm,25,45))+log(unifpdf(sd,0,2));
end

end

function proposaldist=proposaldist(c,T0,Tm,sd)

proposaldist=normrnd([c,T0,Tm,sd],[2e-4,1,1,1e-2]);

end

function [burntchain,acceptance]=MH(x,y,iterations,burnin,startvalue)

chain=zeros(4,iterations+1);

chain(:,1)=startvalue;

acceptcount=0;

for i=1:iterations
    
    proposal=proposaldist(chain(1,i),chain(2,i),chain(3,i),chain(4,i));
    
    probab1=likelihood(proposal(1),proposal(2),proposal(3),proposal(4),x,y)+...
            prior(proposal(1),proposal(2),proposal(3),proposal(4));
        
    probab2=likelihood(chain(1,i),chain(2,i),chain(3,i),chain(4,i),x,y)+...
            prior(chain(1,i),chain(2,i),chain(3,i),chain(4,i));
        
    probab=probab1-probab2;
    
    r=log(rand);
    if r<probab
        chain(:,i+1)=proposal;
        if i>burnin
           acceptcount=acceptcount+1; 
        end
    else
        chain(:,i+1)=chain(:,i);
    end
    

end


acceptance=acceptcount/(iterations-burnin);

burntchain=chain(:,(burnin+2:end));

end