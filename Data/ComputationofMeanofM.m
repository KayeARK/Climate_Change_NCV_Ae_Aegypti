clear
clc

addpath('SuitabilityData202020602100')

P='SuitabilityData202020602100';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'MClimateProjection')
      
        c=[c,S(i)];
        
    end    
end


MAT1=zeros(288,192,100);
MAT2=zeros(288,192,100);
MAT3=zeros(288,192,100);

for p=1:100

x=load(strcat('SuitabilityData202020602100/',c(p).name)).MMedianMat;

x(isnan(x))=0;

x(x>0)=1;

x1=sum(x(:,:,1:12),3);
x2=sum(x(:,:,13:24),3);
x3=sum(x(:,:,25:36),3);


MAT1(:,:,p)=x1;
MAT2(:,:,p)=x2;
MAT3(:,:,p)=x3;

end

Avg2020=mean(MAT1,3);
Avg2060=mean(MAT2,3);
Avg2100=mean(MAT3,3);

Var2020=var(MAT1,0,3);
Var2060=var(MAT2,0,3);
Var2100=var(MAT3,0,3);


%% 

save('SuitabilityDataStatistics202020602100/AvgofSims.mat','Avg2020','Avg2060','Avg2100')
save('SuitabilityDataStatistics202020602100/VarianceMat.mat','Var2020','Var2060','Var2100')

%% 

WorstCase2100=max(MAT3,[],3);
BestCase2100=min(MAT3,[],3);

WorstCase2060=max(MAT2,[],3);
BestCase2060=min(MAT2,[],3);

save('SuitabilityDataStatistics202020602100/BestCase2100.mat','BestCase2100','BestCase2060')
save('SuitabilityDataStatistics202020602100/WorstCase2100.mat','WorstCase2100','WorstCase2060')

