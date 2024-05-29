clc
clear

lowerT=16.6;
upperT=31.7;

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

for p=1:100
    
p

TempPrect=load(strcat('../../../Data/ClimateData/TempPrectData202020602100/',c(p).name));

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

save(strcat('SuitabilityData202020602100/MClimateProjection',num2str(p)),'MMedianMat')

end
