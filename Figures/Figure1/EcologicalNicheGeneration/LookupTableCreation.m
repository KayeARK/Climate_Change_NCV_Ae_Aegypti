clear
clc

%because the climate data set is so large, we don't want to run the
%computation for each temperature, rainfall value in it. Instead we make a
%lookup table to make these computations faster.

%% First, load the MCMC data (chains for each temperature dependent variable)

%note that here we thin the MCMC chains by picking every 20th element. This
%makes the computations faster.

a=load('../../FigureS2toS6/MCMC/Results/a_MCMC_results.mat');
a.burntchain=a.burntchain(:,1:20:end);
gamma=load('../../FigureS2toS6/MCMC/Results/gamma_MCMC_results.mat');
gamma.burntchain=gamma.burntchain(:,1:20:end);
invg=load('../../FigureS2toS6/MCMC/Results/invg_MCMC_results.mat');
invg.burntchain=invg.burntchain(:,1:20:end);
p=load('../../FigureS2toS6/MCMC/Results/p_MCMC_results.mat');
p.burntchain=p.burntchain(:,1:20:end);

%% Compute the lookup table

Temperatures=linspace(0,40,401);
Rainfalls=linspace(0,30,301);

MeanM=zeros(length(Temperatures),length(Rainfalls));
BiggestM=zeros(length(Temperatures),length(Rainfalls));
SmallestM=zeros(length(Temperatures),length(Rainfalls));
MedianM=zeros(length(Temperatures),length(Rainfalls));


for i=1:length(Temperatures)
    
    for j=1:length(Rainfalls)

        T=Temperatures(i);
        R=Rainfalls(j);

        MMat=M(T,R,a,gamma,invg,p);

        y=[prctile(MMat,2.5),mean(MMat),prctile(MMat,97.5),prctile(MMat,50)];

        MeanM(i,j)=y(2);
        SmallestM(i,j)=y(1);
        BiggestM(i,j)=y(3);
        MedianM(i,j)=y(4);

    end
    
end

save('MLookupTable','MeanM','SmallestM','BiggestM','MedianM','Temperatures','Rainfalls')

