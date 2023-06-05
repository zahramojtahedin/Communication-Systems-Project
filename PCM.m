function [SerialCode,q,Vmax,Vmin,len_t,len_ts] = PCM_function(signal ,  n , fs )


% % sounf file 
 %signal = 'alaw08m.wav'
[y,Fs] = audioread(signal); % audio file 
info = audioinfo(signal); % Information about audio file 
if info.NumChannels==2
   y= sum(y, 2) / size(y, 2);
end
% Time domain analysis
t=0:seconds (1/Fs):seconds(info.Duration);  % Time array 
t=t(1:end-1); %Time index adjustment


L = 2^n; %Number of Quantisation Levels

%% Here we pllot the Analog Signal and its Sampled form
Vmax = max(y);
ActualSignl=y; %Actual input



t_sampled=0:seconds (1/fs):seconds(info.Duration);
len_t = length(t)
len_ts = length(t_sampled); 
sampl = linspace(1 , length(y) ,  seconds(info.Duration) / seconds (1/fs));
Sampled_signal = ActualSignl(ceil(sampl));

% subplot(3,1,1);
% plot(t,y');
% xlabel('Time');
% ylabel('Amplitude');
% title('INPUT AUDIO signal');
% sound(y , Fs);
% keyboard
%  subplot(3,1,2); %Sampled Version
% stem(t_sampled(1:end-1), Sampled_signal);grid on; title('Sampled Sinal');
% sound(Sampled_signal,fs)
% keyboard

%% Now perform the Quantization Process
Vmin=min(y); %Since the Signal is sine
StepSize=(Vmax-Vmin)/L; % Diference between each quantisation level
QuantizationLevels=Vmin:StepSize:Vmax; % Quantisation Levels - For comparison
codebook=Vmin-(StepSize/2):StepSize:Vmax+(StepSize/2); % Quantisation Values - As Final Output of qunatiz
[ind,q]=quantiz(Sampled_signal,QuantizationLevels,codebook); % Quantization pprocess
NonZeroInd = find(ind ~= 0);
ind(NonZeroInd) = ind(NonZeroInd) - 1;
% MATLAB gives indexing from 1 to N.But we need indexing from 0, to convert it into binary codebook
BelowVminInd = find(q == Vmin-(StepSize/2));
q(BelowVminInd) = Vmin+(StepSize/2);
%This is for correction, as signal values cannot go beyond Vmin
%But quantiz may suggest it, since it return the Values lower than Actual

%Signal Value
% subplot(3,1,3);
% stem(t_sampled(1:end-1),q);
% grid on; % Display the Quantize values
% title('Quantized Signal');
% sound(q,fs)
% keyboard


% zoom=1500:1550+size(t,2)/120;
% figure(2);
% subplot(3,1,1);
% plot(t(zoom),ActualSignl(zoom),'b');
% title('Part of INPUT AUDIO signal');
% xlabel('Time');
% ylabel('Amplitude');
% subplot(3,1,2);
% stem(t(zoom),Sampled_signal(zoom),'b');
% title('Part of sampled signal');
% xlabel('Time');
% ylabel('Amplitude');
% subplot(3,1,3);
% stem(t(zoom),q(zoom),'b');
% title('Part of Quantized signal');
% xlabel('Time');
% ylabel('Amplitude');

%% Having Quantised the values, we perform the Encoding Process
TransmittedSig = de2bi(ind,'left-msb'); % Encode the Quantisation Level
SerialCode = reshape(TransmittedSig',[1 size(TransmittedSig,1)*size(TransmittedSig,2)]);
% TransmittedSig1 = de2bi(ind,'left-msb'); % Encode the Quantisation Level
% SerialCode1 = reshape(TransmittedSig1',[1 size(TransmittedSig1,1)*size(TransmittedSig1,2)]);
% figure()
% grid on;
% subplot(2,1,1)
% stairs(SerialCode); % Display the SerialCode Bit Stream
% axis([0 200 -2 3]);
% subplot(2,1,2)
% stem(SerialCode(1:20)); % Display the SerialCode Bit Stream
% title('Transmitted Signal');
end

