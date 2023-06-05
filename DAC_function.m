function [sound_out_interp] = DAC_function(recive_bit,n,Vmax,Vmin,len_p,len_t,len_ts)
%% Now we perform the Demodulation Of PCM signal
%RecievedCode=reshape(recive_bit,n,ceil(length(recive_bit)/n)); %Again Convert the SerialCode into Frames of 1 Byte
recive_bit = recive_bit(1:len_p); 
RecievedCode=reshape(recive_bit,n,len_p/n);
index = bi2de(RecievedCode','left-msb'); %Binary to Decimal Conversion
StepSize = (Vmax-Vmin)/(2^n);
q = (StepSize*index); %Convert into Voltage Values
q = q + (Vmin+(StepSize/2)); % Above step gives a DC shfted version of Actual siganl
%Thus it is necessary to bring it to zero level
% figure()
% subplot(2,1,1)
% stem(recive_bit);
% title('resived bits');
% subplot(2,1,2);
% grid on;
% plot(q); % Plot Demodulated signal
% 
% title('Demodulated Signal');

%upsampling

sound_out = q;
sound_out_interp = interp(q, ceil(len_t/len_ts));
end

