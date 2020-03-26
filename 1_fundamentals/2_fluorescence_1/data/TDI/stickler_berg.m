close all 
clear all

%ensemble absorption and emission in PMMA film
load('TDI_absem.mat');

wl = (500:850);
abs_ip = interp1(lambda_absorption,absorption, wl);
em_ip = interp1(lambda_emission, smooth(emission), wl);
abs_ip(isnan(abs_ip)) = 0;
em_ip(isnan(em_ip)) = 0;
em_ip = em_ip ./ max(em_ip);


% plot(wl, abs_ip)
% hold on
% plot(wl, em_ip)
% hold off

%data = [wl; abs_ip; em_ip]';
%save('tdi_abs_em.dat','data','-ascii')


energy = ( 1240 / wl(end): 0.001: 1240 / wl(1));

emission_e = interp1(1240 ./ wl, em_ip ./ wl.^2, energy);
emission_e = emission_e ./ max(emission_e);  
absorption_e = interp1(1240 ./ wl, abs_ip , energy);

hold on
plot(energy, emission_e)
plot(energy, absorption_e)
hold off

%--------
% check mirror rule
figure


p_em = emission_e .* energy.^-3;
p_abs = absorption_e .* energy.^-1;

center = 1.87;
hold on
plot(center - energy, p_em ./ max(p_em))
plot(energy - center, p_abs ./ max(p_abs))
hold off


%------------
% stricker berg eq

h = 4.13e-15; % eV s
omega = energy ./ (h ./ (2 .* pi)); %  energy is in eV !
domega = omega(2) - omega(1);

len = 0.001;  % 1cm
concentration = 1e-5 .* 1e+3; % = 1mM, needs Mol / m^3

absorption_e = absorption_e / 10;  % guess
epsilon = absorption_e ./ (concentration .* len);


int_eps = sum(epsilon ./ omega) .* domega;
int_f = sum(emission_e) .* domega;
int_f_3w = sum(emission_e ./ omega.^3) .* domega;

c = 3e8 ./ 1.3;
NA = 6e23;

k = log(10) ./ ( pi.^2 .* c.^2 .* NA) .* (int_f ./ int_f_3w) .* int_eps;

1 ./ k .* 1e9

% 
% hold on
% plot(1240 ./ lambda_emission, emission,'Color',[1 0 0]);
% plot(1240 ./ lambda_absorption, absorption,'Color',[0 0 1]);
%axis([500 850 0 1.1]);
%ylabel('absorption & emission');
%xlabel('\lambda / nm');
%box on


% figure
% plot(time_tcspc,emission_tcspc,'Color',[1 0 0]);
% axis([-1 10 0 300]);
% ylabel('counts / bin');
% xlabel('time / ns');
% box on
% pbaspect([2 1 1]);
