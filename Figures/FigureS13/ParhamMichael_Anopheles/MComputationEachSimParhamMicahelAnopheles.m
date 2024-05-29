clc
clear

c1=0.00554;
c2=-0.06737;

lowerT=-c2/c1;
upperT=40.0;

lowerR=0;
upperR=50;

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
Prect=TempPrect.R;

Temperature=circshift(Temp,144,1);
Temperature(Temperature<0)=0;
Rainfall=circshift(Prect,144,1);

MMedianMat=zeros(288,192,48);

for l=1:48
    
for j=1:192

for i=1:288

T=Temperature(i,j,l);
R=Rainfall(i,j,l);

MMedian=double((T>=lowerT & T<=upperT)&(R>lowerR & R<upperR));
          
MMedianMat(i,j,l)=MMedian;
end

end

end

save(strcat('SuitabilityData202020602100/MClimateProjection',num2str(p)),'MMedianMat')

end
