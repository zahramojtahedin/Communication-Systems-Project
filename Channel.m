function [y] = Channel(B,N0,A,signal )
sigma = sqrt(N0*B);
t = 0: 0.001:0.1;
x = sigma*randn(1,length(signal));
mam_mod = max(signal);

noise_Signal = signal + x ; 
chnlp_withnoise = conv(noise_Signal, abs(t(2)-t(1))*6*B*sinc(2*B*t));
chnlp_withoutnoise = conv(signal, abs(t(2)-t(1))*6*B*sinc(2*B*t));

chnlp_withoutnoise = chnlp_withoutnoise*mam_mod/max(chnlp_withoutnoise);
chnlp_withnoise = chnlp_withnoise*mam_mod/max(chnlp_withnoise);

mam_mod_noise = max(chnlp_withnoise);
mam_mod_withoutnoise = max(chnlp_withoutnoise);

chnlp_withnoise = chnlp_withnoise*mam_mod_noise/max(chnlp_withnoise);
chnlp_withnoise = chnlp_withnoise * A;

chnlp_withoutnoise = chnlp_withoutnoise*mam_mod_withoutnoise/max(chnlp_withoutnoise);

chnlp_withoutnoise = chnlp_withoutnoise * A;
%figure
% tb=0:seconds (0.001):seconds(0.3);
% tb=tb(1:end-1);
% 
% subplot(3,1,1)
% plot(tb, signal(1:numel(tb)))
% title('Line coded Transmited Signal ')
% subplot(3,1,2)
% plot(tb, chnlp_withoutnoise(1:numel(tb)))
% title('Lp signal without Noise')
% subplot(3,1,3)
% plot(tb, chnlp_withnoise(1:numel(tb)));
% title('Lp signal with Noise')

y = chnlp_withnoise;
end

