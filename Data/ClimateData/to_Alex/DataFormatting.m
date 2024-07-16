Data=ncinfo('b.e21.BSSP245smbb.f09_g17.016.cam.h0.TREFHT.210001-210012.nc');

T=ncread('b.e21.BSSP245cmip6.f09_g17.CMIP6-SSP2-4.5.103.cam.h0.TREFHT.210001-210012.nc','TREFHT');
T=T-273.15;

R=ncread('b.e21.BSSP245cmip6.f09_g17.CMIP6-SSP2-4.5.103.cam.h0.PRECT.210001-210012.nc','PRECT');
R=R*86.4e6;

save('TempPrect19','T','R')


