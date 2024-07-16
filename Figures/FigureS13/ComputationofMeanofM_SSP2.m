clear
clc

addpath('SuitabilityData2100')

P='SuitabilityData2100';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'MClimateProjection')
      
        c=[c,S(i)];
        
    end    
end


MAT1=zeros(288,192,19);


for p=1:19

x=load(strcat('SuitabilityData2100/',c(p).name)).MMedianMat;

x(isnan(x))=0;

x(x>0)=1;

x1=sum(x(:,:,1:12),3);


MAT1(:,:,p)=x1;

end

Avg2100=mean(MAT1,3);

Var2100=var(MAT1,0,3);


%% 

save('SuitabilityDataStatistics2100/AvgofSims.mat','Avg2100')
save('SuitabilityDataStatistics2100/VarianceMat.mat','Var2100')

%% 

WorstCase2100=max(MAT1,[],3);
BestCase2100=min(MAT1,[],3);


save('SuitabilityDataStatistics2100/BestCase2100.mat','BestCase2100')
save('SuitabilityDataStatistics2100/WorstCase2100.mat','WorstCase2100')

