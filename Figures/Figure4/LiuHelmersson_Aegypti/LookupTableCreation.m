clear
clc

%because the climate data set is so large, we don't want to run the
%computation for each temperature, rainfall value in it. Instead we make a
%lookup table to make these computations faster.

%% First, load the MCMC data (chains for each temperature dependent variable)

f=0.5;
c2=0.1;
c0=5;
c1=30;
q0=0.2;
q1=0.02;
q2=0.037;
mu_al=0.001;
mu_pa=0.001;
W_c=30;

sigma_l_data=readtable('sigma_l.csv');
sigma_p_data=readtable('sigma_p.csv');

%% Compute the lookup table

Temperatures=linspace(0,40,401);
Rainfalls=linspace(0,100,1001);

MedianM=zeros(length(Temperatures),length(Rainfalls));


for i=1:length(Temperatures)
    
    for j=1:length(Rainfalls)

        T=Temperatures(i);
        R=Rainfalls(j);

        sigma_l=interp1(sigma_l_data.x,sigma_l_data.y,T);
        sigma_p=interp1(sigma_p_data.x,sigma_p_data.y,T);
    
        q=(q1.*R./(q0+q1*R))+q2;
        C=(c0.*R./(c1+R))+c2;
        phi=max(0,-5.3999+(1.800160*T)-(2.12e-1*(T.^2))+(1.02e-2*(T.^3))-(1.51e-4*(T.^4)));
        mu_a=(8.69e-1)-((1.59e-1)*T)+(1.12e-2*(T.^2))-(3.41e-4*(T.^3))+(3.81e-6*(T.^4));
        mu_l_t=2.31532-((4.19e-1)*T)+(2.73e-2*(T.^2))-(7.53e-4*(T.^3))+(7.5e-6*(T.^4));
        mu_p_t=(4.25e-1)-((3.25e-2)*T)+(7.06e-4*(T.^2))+(4.39e-7*(T.^3));
        mu_l=mu_l_t*((heaviside(R-W_c).*mu_al.*(R-W_c))+1);
        mu_p=mu_p_t*((heaviside(R-W_c).*mu_pa.*(R-W_c))+1);
        alpha=(mu_a./sigma_p).*(1./(phi.*q*f)).*(mu_p+sigma_p).*(1+(mu_l./sigma_l));
    
    
        A=max(0,C.*(sigma_p./mu_a).*(sigma_l./(mu_p+sigma_p)).*(1-alpha));

        
        MedianM(i,j)=double(A>0);

    end
    
end

save('MLookupTable','MedianM','Temperatures','Rainfalls')

