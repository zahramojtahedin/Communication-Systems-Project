%Calculate BER
clc;
clear all;
close all;
% n=input('Enter for n-bit PCM system : '); %Encodebook Bit Length
% fs=input('Enter Sampling Frequency : '); %Sampling Frequency
% signal= input('Enter voice signal: '); % Inpit Signal
% 
% %%LineCode_function_Input
% 
% rolloff=input('Enter rolloff factor : '); % rolloff factor
% r =input('Enter baud rate r: '); % baud rate
% A = input('Enter amplitude A: '); % amplitude
% 
% %channel Input
% B = input('Enter channel bandwidth : ') ;
% N0 = input('Enter noise power spectral density : ') ;
% A_C = input('Enter amplitude A_Channel: '); % amplitude


n=2; %Encodebook Bit Length
fs=4000; %Sampling Frequency
signal=  'voice.wav'; % Inpit Signal
% rolloff factor
r =20; % baud rate
rolloff=6; % rolloff factor
A = 1; % amplitude
B = 12 ;

A_C = 1;
t=0:0.001:0.1;
[y,Fs] = audioread(signal); % audio file 
info = audioinfo(signal); % Information about audio file 
[SerialCode,q ,Vmax,Vmin,len_t,len_ts] = PCM_function(signal ,  n , fs);
[Pulse, Power,s,len_p] = Linecode_function(rolloff,r, A , SerialCode);

BER = [];
error_norm_F = [];
for N0 = 0:0.001:0.5
    error_m = [];
    error_norm = [];
 for Monti=1:5
Pulse_output_channel = Channel(B,N0,A_C,Pulse);
 r_bit = Line_Decoder(Pulse_output_channel,SerialCode,r,s);
  sound_out = DAC_function(r_bit,n,Vmax,Vmin,len_p,len_t,len_ts)
% error_m =[error_m , sum(abs(r_bit(1:length(SerialCode))-SerialCode))];
error_m =[error_m , sum(abs(r_bit(1:length(len_p))-SerialCode(1:length(len_p))))];
error_norm = [error_norm , norm( sound_out' - interp(q, ceil(len_t/len_ts)), 2)]
 end 
 BER = [BER , mean(error_m)];
 error_norm_F = [error_norm_F , mean(error_norm)/norm(interp(q, ceil(len_t/len_ts)))];
end
figure()
plot(0:0.001:0.5 , error_norm_F)
title('error recovery')
