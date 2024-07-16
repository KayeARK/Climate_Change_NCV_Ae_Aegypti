%change all "CapeTown" to either London or Islamabad to generate these data

load('CapeTown1850to2100.mat')
MLookup=load('../Figure1/EcologicalNicheGeneration/MLookupTable.mat');
MedianM=MLookup.MedianM;

CapeTownR2020=RCapeTown(:,2041:2052);
CapeTownR2030=RCapeTown(:,2161:2172);
CapeTownR2040=RCapeTown(:,2281:2292);
CapeTownR2050=RCapeTown(:,2401:2412);
CapeTownR2060=RCapeTown(:,2521:2532);
CapeTownR2070=RCapeTown(:,2641:2652);
CapeTownR2080=RCapeTown(:,2761:2772);
CapeTownR2090=RCapeTown(:,2881:2892);
CapeTownR2091=RCapeTown(:,2893:2904);
CapeTownR2092=RCapeTown(:,2905:2916);
CapeTownR2093=RCapeTown(:,2917:2928);
CapeTownR2094=RCapeTown(:,2929:2940);
CapeTownR2095=RCapeTown(:,2941:2952);
CapeTownR2096=RCapeTown(:,2953:2964);
CapeTownR2097=RCapeTown(:,2965:2976);
CapeTownR2098=RCapeTown(:,2977:2988);
CapeTownR2099=RCapeTown(:,2989:3000);
CapeTownR2100=RCapeTown(:,3001:3012);

RCapeTown=cat(3,CapeTownR2020,CapeTownR2030,CapeTownR2040,CapeTownR2050,CapeTownR2060,CapeTownR2070,CapeTownR2080,CapeTownR2090,CapeTownR2100);
RCapeTown20902100=cat(3,CapeTownR2090,CapeTownR2091,CapeTownR2092,CapeTownR2093,CapeTownR2094,CapeTownR2095,CapeTownR2096,CapeTownR2097,CapeTownR2098,CapeTownR2099,CapeTownR2100);

CapeTownT2020=TCapeTown(:,2041:2052);
CapeTownT2030=TCapeTown(:,2161:2172);
CapeTownT2040=TCapeTown(:,2281:2292);
CapeTownT2050=TCapeTown(:,2401:2412);
CapeTownT2060=TCapeTown(:,2521:2532);
CapeTownT2070=TCapeTown(:,2641:2652);
CapeTownT2080=TCapeTown(:,2761:2772);
CapeTownT2090=TCapeTown(:,2881:2892);
CapeTownT2091=TCapeTown(:,2893:2904);
CapeTownT2092=TCapeTown(:,2905:2916);
CapeTownT2093=TCapeTown(:,2917:2928);
CapeTownT2094=TCapeTown(:,2929:2940);
CapeTownT2095=TCapeTown(:,2941:2952);
CapeTownT2096=TCapeTown(:,2953:2964);
CapeTownT2097=TCapeTown(:,2965:2976);
CapeTownT2098=TCapeTown(:,2977:2988);
CapeTownT2099=TCapeTown(:,2989:3000);
CapeTownT2100=TCapeTown(:,3001:3012);

TCapeTown=cat(3,CapeTownT2020,CapeTownT2030,CapeTownT2040,CapeTownT2050,CapeTownT2060,CapeTownT2070,CapeTownT2080,CapeTownT2090,CapeTownT2100);
TCapeTown20902100=cat(3,CapeTownT2090,CapeTownT2091,CapeTownT2092,CapeTownT2093,CapeTownT2094,CapeTownT2095,CapeTownT2096,CapeTownT2097,CapeTownT2098,CapeTownT2099,CapeTownT2100);

%% 

MMedianMat=zeros(100,12,9);

for l=1:11

for j=1:12

for i=1:100

T=TCapeTown20902100(i,j,l);
R=RCapeTown20902100(i,j,l);

k=(300/4.59)*R*(1/25)/(5+245+R); %carrying capacity
if R<0.5
    k=0;
end 

MMedian=k*MedianM(min(401,int64(10*T)+1),min(301,int64(10*R)+1));
           
MMedianMat(i,j,l)=MMedian;

end

end

end

MMedianMat(MMedianMat>0)=1;

MMedianMat=squeeze(sum(MMedianMat,2));

save(strcat('SuitabilityDataCapeTown20902100'),'MMedianMat')
