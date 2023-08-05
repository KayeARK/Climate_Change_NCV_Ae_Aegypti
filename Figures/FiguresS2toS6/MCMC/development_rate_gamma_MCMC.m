clear
clc

%% Data

%read data for use in MCMC
T=readtable('aegyptiDENVmodelTempData_2016-03-30.csv');

x=T.trait_name;
temps=T.T;
traits=T.trait;
yprime=T.ref;

y=strings(1,length(x));
for i=1:length(x)
      y(i)=num2str(cell2mat(x(i)));
end


MDRT=[];
MDR=[];

%extract development rate data from the datset
for i=1:length(x)
    if y(i)=='MDR' %what we refer to as "gamma" is called MDR (mosquito development rate) in this dataset
        MDRT=[MDRT temps(i)];
        MDR=[MDR traits(i)];
    end
end

x=MDRT; %for ease of naming we refer to the temperature as x and the response as y
y=MDR;

%% MCMC


iterations=100000;
burnin=50000;

M=5; %M controls the number of chains run in order to compute the GR statistic

posteriormean=[];
posteriorvar=[];

for i=1:M
    
    %to compute the GR statistic, we initialise each round of MCMC
    %differently according to wide uniform distributions
    startvalue=[1e-5 + (1e-3-1e-5)*rand(1), 0+(20)*rand(1),20+(50-20)*rand(1),0+(1)*rand(1)];
    [burntchain,acceptance]=MH(x,y,iterations,burnin,startvalue);
    posteriormean(:,i)=mean(burntchain,2);
    posteriorvar(:,i)=var(burntchain,0,2);
    chains{i}=burntchain;
    
end

%% Steps to compute the Gelman-Rubin statistic

totmean=mean(posteriormean,2);

B=(iterations/(M-1))*(sum((posteriormean-totmean).^2,2));
W=mean(posteriorvar,2);

Vtilde=(((iterations-1)/iterations)*W)+(((M+1)/(iterations*M))*B);

R=sqrt(Vtilde./W);

%% Save the output

save('Results/gamma_MCMC_results.mat','burntchain','acceptance','R')


%% Functions for the MCMC


%Briere likelihood function
function likelihood=likelihood(c,T0,Tm,sd,x,y)

pred=max(0,real(c.*x.*(x-T0).*sqrt(Tm-x)));
likelihood=sum(log(normpdf(y,pred,sd)));

end


function prior=prior(c,T0,Tm,sd)

prior=log(gampdf(c,9,1e-5))+log(gampdf(T0,7,2))+log(gampdf(Tm,10,4))+log(unifpdf(sd,0,1));

end

%specifies the covariance matrix of the proposal distribution
function proposaldist=proposaldist(c,T0,Tm,sd)

proposaldist=normrnd([c,T0,Tm,sd],[5e-6,0.5,0.5,0.01]);

end

%main MCMC function
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