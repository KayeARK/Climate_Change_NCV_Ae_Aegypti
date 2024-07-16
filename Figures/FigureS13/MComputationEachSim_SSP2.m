clc
clear

MLookup=load('../Figure1/EcologicalNicheGeneration/MLookupTable.mat');

MedianM=MLookup.MedianM;

addpath('../../Data/ClimateData/TempPrectData2100SSP2')

P='../../Data/ClimateData/TempPrectData2100SSP2';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'TempPrect')
      
        c=[c,S(i)];
        
    end    
end

%% 

for p=1:19
    
p

TempPrect=load(strcat('../../Data/ClimateData/TempPrectData2100SSP2/',c(p).name));

Prect=TempPrect.R;
Temp=TempPrect.T;

Temperature=circshift(Temp,144,1);
Rainfall=circshift(Prect,144,1);
Temperature(Temperature<0)=0;

MMedianMat=zeros(288,192,48);
MSmallestMat=zeros(288,192,48);
MBiggestMat=zeros(288,192,48);

for l=1:12
    
for j=1:192

for i=1:288

T=Temperature(i,j,l);
R=Rainfall(i,j,l);

k=(300/4.59)*R*(1/25)/(5+245+R); %carrying capacity
if R<0.5
    k=0;
end  
   
MMedian=k*MedianM(min(401,int64(10*T)+1),min(301,int64(10*R)+1));
           
MMedianMat(i,j,l)=MMedian;

end

end

end

save(strcat('SuitabilityData2100/MClimateProjection',num2str(p)),'MMedianMat','MSmallestMat','MBiggestMat')

end
