clc
clear

MLookup=load('MLookupTable.mat');

MedianM=MLookup.MedianM;

addpath('../../../Data/ClimateData/TempPrectData202020602100')

P='../../../Data/ClimateData/TempPrectData202020602100';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'TempPrect')
      
        c=[c,S(i)];
        
    end    
end

%% 

TempPrect=load('../../../Data/ClimateData/AvgTempPrectData202020602100/AvgTempPrect.mat');

Prect=TempPrect.R;
Temp=TempPrect.T;

Temperature=circshift(Temp,144,1);
Rainfall=circshift(Prect,144,1);
Temperature(Temperature<0)=0;

MMedianMat=zeros(288,192,48);


for l=1:48
    
for j=1:192

for i=1:288

T=Temperature(i,j,l);
R=Rainfall(i,j,l);

MMedian=MedianM(min(401,int64(10*T)+1),min(1001,int64(10*R)+1));
           
MMedianMat(i,j,l)=MMedian;

end

end

end

save('SuitabilityDataAvg202020602100/MAvgClimateProjection','MMedianMat')

