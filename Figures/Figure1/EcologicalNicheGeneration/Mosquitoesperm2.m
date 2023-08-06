%these functions compute the number of mosquitoes per m^2 of area as a
%function of temperature and rainfall

function MosPop=Mosquitoesperm2(T,R,a,gamma,invg,p)

MParams=TempFit(T,a,gamma,invg,p);
decay=1;
q0=(2./(MParams.invgT.*MParams.aT)).*((1./MParams.pT)+((96/(121*decay)).*(R./MParams.gammaT)));
flush=1-q0;
MosPop=flush.*(121/192).*MParams.invgT.*MParams.gammaT;
MosPop(isnan(MosPop))=0;
MosPop(MosPop<0)=0;

end

%function to compute mosquito temperature fitted parameters at given T
function MParams=TempFit(T,a,gamma,invg,p)

chain=a.burntchain;
aT = max(0,real(chain(1,:)*T.*(T-chain(2,:)).*sqrt(chain(3,:)-T)))';

chain=gamma.burntchain;
gammaT = max(0,real(chain(1,:)*T.*(T-chain(2,:)).*sqrt(chain(3,:)-T)))';

chain=invg.burntchain;
invgT = max(0,-chain(1,:).*(T-chain(2,:)).*(T-chain(3,:)))';    
    
chain=p.burntchain;
pT = max(0,-chain(1,:).*(T-chain(2,:)).*(T-chain(3,:)))';

MParams=struct('aT',aT,'gammaT',gammaT,'invgT',invgT,'pT',pT);

end


