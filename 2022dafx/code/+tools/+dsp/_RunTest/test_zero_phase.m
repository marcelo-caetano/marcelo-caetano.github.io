%[y,fs,b]=wavread('Maple.wav');
% Constants
window_size = 4001;
fs = 44100;
time = (0:window_size-1)/fs;
fft_size = 2^nextpow2(window_size);
fft_scale = 1/fs; % equivalent to multiplying by the sampling period T

% Auxiliary
freq_Hz = linspace(0,fs/2,fft_size/2+1)';
freq_Rad = linspace(0,pi,fft_size/2+1)';

% Signal
y = cos(2*pi*1000.*time-pi/2)';

% Blackman-Harris window
aux_win = blackmanharris(window_size);
% Force BH window to be symmetrical around zero
%BH_Win = [aux_win((window_size-1)/2+1:end);zeros(fft_size-window_size,1); aux_win(end:-1:end-(window_size-1)/2+1)];
%BH_Win(window_size/2+1:end) = aux_win(end:-1:window_size/2+1);
window_scale = 1/sum(aux_win);

% Windowing
%aa = window_scale*aux_win.*y(round(length(y)/2):round(length(y)/2)+window_size-1);
aa = window_scale*aux_win.*y; % Central sample of aux_win falls on y((window_size-1)/2)

% Zero-Phase FFT
bb = [aa((window_size-1)/2:end);zeros(fft_size-window_size,1);aa(end:-1:end-(window_size-1)/2+1)];
BB = fft_scale*fft(bb,fft_size);
BB_spec(2:fft_size/2+1) = 2*abs(BB(2:fft_size/2+1));
BB_spec(1) = abs(BB(1));

figure
subplot(2,1,1)
plot(freq_Hz,20*log10(abs(BB_spec(1:fft_size/2+1))),'k')
subplot(2,1,2)
plot(freq_Hz,angle(BB(1:fft_size/2+1)),'k')

figure
subplot(2,1,1)
plot(freq_Rad,20*log10(abs(BB_spec(1:fft_size/2+1))),'k')
subplot(2,1,2)
plot(freq_Rad,angle(BB(1:fft_size/2+1)),'k')

figure
plot(time,aux_win,'k')

% FFT of BW window
BH_Win = fft_scale*fft(window_scale*aux_win,fft_size);
BH_Win(2:fft_size/2+1) = 2*BH_Win(2:fft_size/2+1);

% ph_bh_win = angle(BH_Win);
% % Unwrap phase
% aux=[ph_bh_win(1);ph_bh_win(2)+pi;ph_bh_win(3);ph_bh_win(4)+pi;ph_bh_win(5:512);ph_bh_win(513)+pi/2;ph_bh_win(514:1021)+pi;ph_bh_win(1022);ph_bh_win(1023)+pi;ph_bh_win(1024)];
% aux_ph = exp(aux);

figure
subplot(2,1,1)
plot(freq_Hz,20*log10(abs(BH_Win(1:fft_size/2+1))),'k')
subplot(2,1,2)
plot(freq_Hz,angle(BH_Win(1:fft_size/2+1)),'k')

% DCT of BH window
BHWin = dct(BH_Win,fft_size);
figure(3)
subplot(2,1,1)
plot(freq_Hz,BHWin(1:fft_size/2+1),'k')
subplot(2,1,2)
plot(freq_Hz,angle(BHWin(1:fft_size/2+1)),'k')

% DCT of BH window
BHWIN = dct(aux_win,fft_size);
figure(4)
subplot(2,1,1)
plot(freq_Hz,abs(BHWIN(1:fft_size/2+1)),'k')
subplot(2,1,2)
plot(freq_Hz,angle(BHWIN(1:fft_size/2+1)),'k')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FREQUENCY DOMAIN ZERO PHASE ESTIMATION

% System coefficients from impulse response = bw_win
[B,A] = prony(BH_Win,5,5);

% Zero Phase response for system coefficients B,A
[Hr,W] = zerophase(B,A,fft_size);

% System coefficients from frequency response Hr
[b,a] = invfreqz(Hr,W,5,5,[],30,0.001);

% Obtain zero-phase BH window as impulse response of system [b,a]
[bhw,t] = impz(b,a,window_size,fs);

figure(5)
plot(time,bhw,'b')

BHW = fft_scale*fft(bhw,fft_size);
BHW(2:fft_size/2+1) = 2*BHW(2:fft_size/2+1);

figure(6)
subplot(2,1,1)
plot(freq_Hz,abs(BHW(1:fft_size/2+1)),'b')
subplot(2,1,2)
plot(freq_Hz,angle(BHW(1:fft_size/2+1)),'b')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TIME DOMAIN ZERO PHASE ESTIMATION

% Zero phase window
sbhw = fftshift(BH_Win);
% function fftshift gives the same result as
% aux_win(1:window_size/2) = BH_Win(window_size/2+1:window_size);
% aux_win(window_size/2+1:window_size) = BH_Win(1:window_size/2);

figure(7)
plot(time,sbhw,'r')

SBHW = fft_scale*fft(window_scale*sbhw,fft_size);
SBHW(2:fft_size/2+1) = 2*SBHW(2:fft_size/2+1);

figure(6)
subplot(2,1,1)
plot(freq_Hz,abs(SBHW(1:fft_size/2+1)),'r')
subplot(2,1,2)
plot(freq_Hz,angle(SBHW(1:fft_size/2+1)),'r')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Blackman-Harris Window

% Coefficients
a = [0.35875 0.48829 0.14128 0.01168];

% Analytic Expression
syms n;

% Symmetric BH-Window
bh_window = a(1)-a(2)*cos((2*pi*n)/(window_size-1))+a(3)*cos((4*pi*n)/(window_size-1))-a(4)*cos((2*pi*n)/(window_size-1));

% Z-Transform
zt_bh_window = ztrans(bh_window);

% Convert to H(z)=N(z)/D(z)
[N,D] = numden(zt_bh_window);

% Collect terms
N = collect(N);
D = collect(D);

% Convert to polynomial
num = sym2poly(N);
den = sym2poly(D);

% Evaluate Zero-Phase Response
[Hr,rads] = zerophase(num,den,fft_size);

figure(8)
plot(rads,Hr)

% Impulse Response
impz(num,den,window_size)

% Impulse Reponse via Filtering
imp = [1; zeros(window_size-1,1)];
h = filter(num,den,imp);

norm_h=h/sum(h);

plot(BH_Win)
hold on
plot(norm_h,'r')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BH_Win = blackmanharris(window_size);
bh_win_factor = 1/sum(BH_Win);
BH_Win = bh_win_factor*BH_Win;

% Autocorrelation
ac_bh_win = xcorr(BH_Win);

plot(ac_bh_win)

fft_ac_bh_win = fft(ac_bh_win,fft_size);
