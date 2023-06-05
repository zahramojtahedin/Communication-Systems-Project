function [r_bit] = Line_Decoder(signal,serialcode,r,s)
r_bit=[];

for k =1:s:length(signal)
   if  signal(k) >=0 
      r_bit = [r_bit , 1] ;
   else 
       r_bit = [r_bit , 0];
   end
end
% tb=0:seconds (0.001):seconds(0.3);
% tb=tb(1:end-1);
% figure
% subplot(3,1,1)
% plot(tb, signal(1,(1:numel(tb))))
% title('Line decoder recived Signal ')
% subplot(3,1,2)
% stem(r_bit)
% title('recived bit after decoder ')
% subplot(3,1,3)
% stem(serialcode)
% title('original transmited bit')
end

