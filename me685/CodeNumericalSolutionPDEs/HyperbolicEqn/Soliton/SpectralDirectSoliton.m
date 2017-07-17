%% SpectralDirectSoliton.m

%% Author: Louise Olsen-Kettle (email: l.kettle1@uq.edu.au, @DrOlsen-Kettle)
%% Code to supplement lecture notes by Louise Olsen-Kettle:
%% Numerical solution of Partial Differential Equations (PDEs)
%% Webpage: http://espace.library.uq.edu.au/view/UQ:239427
%% ISBN: 978-1-74272-149-1

% using the spectral method directly for the KdV equation : U_t + U U_x + U_xxx = 0

x1=0;
a = 2.*pi; % length in x-direction
x2=a;

A = 100; % A = maximum amplitude of the soliton
V=A/3.; % V = speed at which the solition travels

T = 2.*pi/V; % length of time for solution

n = 128;   % no of grid points Xn

dx = a/(2.*n); % grid spacing in x direction

dt = T/320000.;

m = 40 % round(T/dt); 

t=0.; % initial time = 0

% set up mesh in x-direction:
x = linspace(x1,x2-dx, 2*n)';

% matlab stores wave numbers differently from us:
nu = [0:n  -n+1:-1]';

% define U^0 at t_k = 0 
U_tk_1 = A*sech(sqrt(A/12.)*(x-pi)).^2;

% define U^(-1) at t_k = -1
% using U^(-1) = U^0(x+V*dt) since soliton moves at speed V and t=-dt :
% general solution: U(x,t) = A*sech(sqrt(A/12.)*(x-pi - Vt))^2
U_tk_2 =  A*sech(sqrt(A/12.)*(x + V*dt -pi)).^2;

figure(1)
plot (x,U_tk_1,'-')
%axis ([0 2*pi 0 2])
title ('Initial condition for U')
xlabel ('x')
ylabel ('U')

% store solution every 100th timestep in matrix U(nxm):

U=zeros(2*n,round(m/100));
tvec=zeros(round(m/100),1);

U(:,1) = U_tk_1;
tvec(1) = t;

U_tk = zeros(2*n,1);

kk=1;
% now march solution forward in time using U_tk+1 = U_tk-1 - 2*i*dt*(c(x)*ifft(nu*fft(U_tk))) :

for k = 1:m-1
    t = t+dt;

    uhat = fft(U_tk_1);
    what = 1i*nu.*(uhat);
    w = real(ifft(what));
    uhat = fft(U_tk_1);
    what = -1i*(nu.^3).*(uhat);
    www = real(ifft(what));

    U_tk = U_tk_2 - 2*dt*(U_tk_1.*w + www) ;
    % for next time step:
    U_tk_2 = U_tk_1;
    U_tk_1 = U_tk;

    if mod(k,1)==0
       U(:,kk+1) = U_tk;
       tvec(kk+1) = t;
       kk=kk+1;
    end

end



figure(2)
waterfall(x,tvec,U')
%axis ([0 1 0 2 0 1.1])
title ('Variation of U with time')
xlabel ('x')
ylabel ('t')
zlabel ('U')


figure(3)
plot (x,U_tk)
%axis ([0 2 0 1.1])
title('Final solution at t=9')
xlabel ('x')
ylabel ('U')
































