function M = julia(zmin, zmax, hpx, niter, c)
%% Number of vertical pixels
   vpx=round(hpx*abs(imag(zmax-zmin)/real(zmax-zmin)));
%% Prepare the complex plane
   [zRe,zIm]=meshgrid(linspace(real(zmin),real(zmax),hpx),
   linspace(imag(zmin),imag(zmax),vpx));
   z=zRe+i*zIm;
   M=zeros(vpx,hpx);
%% Generate Julia
   for s=1:niter
       mask=abs(z)<2;
       M(mask)=M(mask)+1;
       z(mask)=z(mask).^2+c;
   end
   M(mask)=0;
end
