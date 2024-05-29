clc
clear

lowerT=16.2;
upperT=31.6;

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

Temp=TempPrect.T;

Temperature=circshift(Temp,144,1);
Temperature(Temperature<0)=0;

MMedianMat=zeros(288,192,48);

for l=1:48
    
for j=1:192

for i=1:288

T=Temperature(i,j,l);

MMedian=double((T>=lowerT & T<=upperT));         
MMedianMat(i,j,l)=MMedian;

end

end

end

save('SuitabilityDataAvg202020602100/MAvgClimateProjection','MMedianMat')

