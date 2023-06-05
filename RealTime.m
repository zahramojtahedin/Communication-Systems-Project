%%RealTIME 
clc; 
clear all; 
close all;

%%get audio
recObj = audiorecorder;
disp('Start speaking.')
recordblocking(recObj, 3);
disp('End of Recording.');
y = getaudiodata(recObj);
formatSpec = 'input_file_.wav'
output_file = sprintf(formatSpec);
audiowrite(output_file,y,8000);
figure
plot(y);
sound(y)
keyboard
%%%ADC_Function Input
n=input('Enter for n-bit PCM system : '); %Encodebook Bit Length
fs=input('Enter Sampling Frequency : '); %Sampling Frequency
signal= input('Enter voice signal: '); % Inpit Signal

%%LineCode_function_Input
rolloff=input('Enter rolloff factor : '); % rolloff factor
r =input('Enter baud rate r: '); % baud rate
A = input('Enter amplitude A: '); % amplitude

%channel Input
B = input('Enter channel bandwidth : ') ;
N0 = input('Enter noise power spectral density : ') ;
A_C = input('Enter amplitude A_Channel: '); % amplitude

% n=2; %Encodebook Bit Length
% fs=4000; %Sampling Frequency
% 
% rolloff factor
% r =20; % baud rate
% rolloff=6; % rolloff factor
% A = 1; % amplitude
% B = 12 ;
% 
% A_C = 1;
% t=0:0.001:0.1;
% [y,Fs] = audioread(signal); % audio file 
% info = audioinfo(signal); % Information about audio file 
% [SerialCode,q ,Vmax,Vmin,len_t,len_ts] = PCM_function(signal ,  n , fs);
% [Pulse, Power,s,len_p] = Linecode_function(rolloff,r, A , SerialCode);
% N0 = 1e-2*Power;
Pulse_output_channel = Channel(B,N0,A_C,Pulse);
 r_bit = Line_Decoder(Pulse_output_channel,SerialCode,r,s);
 sound_out = DAC_function(r_bit,n,Vmax,Vmin,len_p,len_t,len_ts)
sound(sound_out,Fs)
%%Write .wav 
formatSpec = 'output_file_%d_.wav'
output_file = sprintf(formatSpec,N0/Power);
audiowrite(output_file,sound_out,Fs);