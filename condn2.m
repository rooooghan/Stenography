function [d2] = condn1(CP,NP,d1)


DB=dec2bin(d1,8);
DB=bitget(uint8(DB),1);

% m1=length(dec2bin(CP));
% m2=length(dec2bin(NP));
DB(5)=bitget(CP,2);
DB(6)=bitget(CP,1); %%hide 2 bits in Current Pixel
DB(7)=bitget(NP,2); 
DB(8)=bitget(NP,1); %%hide 2 bits in Next Pixel

RT=[DB(5),DB(6),DB(7),DB(8),DB(1),DB(2),DB(3),DB(4)];
RT=dec2bin(RT);
RT=RT';
d2=bin2dec(RT);