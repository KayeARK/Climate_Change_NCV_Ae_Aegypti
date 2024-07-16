clc
clear

MLookup=load('../Figure1/EcologicalNicheGeneration/MLookupTable.mat');

MedianM=MLookup.MedianM;

addpath('../../Data/ClimateData/TempPrectData202020602100')

P='../../Data/ClimateData/TempPrectData202020602100';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'TempPrect')
      
        c=[c,S(i)];
        
    end    
end

%% 

for p=1:100
    
p

TempPrect=load(strcat('../../Data/ClimateData/TempPrectData202020602100/',c(p).name));

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
R=3;

   
MMedian=MedianM(min(401,int64(10*T)+1),min(1001,int64(10*R)+1));
           
MMedianMat(i,j,l)=MMedian;

end

end

end

save(strcat('SuitabilityData202020602100/MClimateProjection',num2str(p)),'MMedianMat','MSmallestMat','MBiggestMat')

end
