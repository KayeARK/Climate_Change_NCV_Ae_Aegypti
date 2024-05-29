clc
clear

MLookup=load('../Figures/Figure1/EcologicalNicheGeneration/MLookupTable.mat');

MedianM=MLookup.MedianM;
BiggestM=MLookup.BiggestM;
SmallestM=MLookup.SmallestM;

addpath('ClimateData/TempPrectData202020602100')

P='ClimateData/TempPrectData202020602100';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'TempPrect')
      
        c=[c,S(i)];
        
    end    
end

%% 

TempPrect=load('ClimateData/AvgTempPrectData202020602100/AvgTempPrect.mat');

Prect=TempPrect.R;
Temp=TempPrect.T;

Temperature=circshift(Temp,144,1);
Rainfall=circshift(Prect,144,1);
Temperature(Temperature<0)=0;

MMedianMat=zeros(288,192,48);
MSmallestMat=zeros(288,192,48);
MBiggestMat=zeros(288,192,48);

for l=1:48
    
for j=1:192

for i=1:288

T=Temperature(i,j,l);
R=Rainfall(i,j,l);

k=(300/4.59)*R*(1/25)/(5+245+R); %carrying capacity
if R<0.5
    k=0;
end 
MMedian=k*MedianM(min(401,int64(10*T)+1),min(301,int64(10*R)+1));
MBiggest=k*BiggestM(min(401,int64(10*T)+1),min(301,int64(10*R)+1));
MSmallest=k*SmallestM(min(401,int64(10*T)+1),min(301,int64(10*R)+1));
           
MMedianMat(i,j,l)=MMedian;
MSmallestMat(i,j,l)=MSmallest;
MBiggestMat(i,j,l)=MBiggest;

end

end

end

save('SuitabilityDataAvg202020602100/MAvgClimateProjection','MMedianMat','MSmallestMat','MBiggestMat')

