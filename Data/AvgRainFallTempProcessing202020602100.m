clear
clc

%this script averages over the climate data to compute a single mean
%projection
addpath('ClimateData/TempPrectData202020602100')

P='ClimateData/TempPrectData202020602100';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'TempPrect')
      
        c=[c,S(i)];
        
    end    
end

 
MATR=zeros(288,192,48,100);
MATT=zeros(288,192,48,100);

for p=1:100
   p 
x=load(strcat('ClimateData/TempPrectData202020602100/',c(p).name));
Temp=x.T;
Prect=x.R;

MATR(:,:,:,p)=Prect;
MATT(:,:,:,p)=Temp;

end
 
R=mean(MATR,4);
T=mean(MATT,4);

save('ClimateData/AvgTempPrectData202020602100/AvgTempPrect.mat','R','T')
